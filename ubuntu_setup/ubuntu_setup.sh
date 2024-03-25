export TZ=Asia/Shanghai
export LANG=C.UTF-8
export DEBIAN_FRONTEND=noninteractive

echo 'deb https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse' > /etc/apt/sources.list

export APT_ESSENTIAL='apt-utils git systemctl ssh zsh curl wget python3 python3-dev pip fontconfig tzdata cron default-libmysqlclient-dev build-essential nmap'
export APT_SUB='unzip vim lsof net-tools apt-utils mysql-client iputils-ping x11vnc xvfb fluxbox zsh wireguard'
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt update && apt upgrade -y 
apt -qq install $APT_ESSENTIAL -y --allow-remove-essential
apt -qq install $APT_SUB -y --allow-remove-essential
apt autoremove -y && apt clean -y

chsh -s $(which zsh)
echo 'y' | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# powerlevel10k
# git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
# git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
# cp config/.p10k.zsh /root/.p10k.zsh
# cp config/.zshrc /root/.zshrc
# cp config/.fzf.zsh /root/.fzf.zsh

# basic theme
echo 'export ZSH="$HOME/.oh-my-zsh"' > $HOME/.zshrc
echo 'ZSH_THEME="ys"' >> $HOME/.zshrc
echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting sudo)' >> $HOME/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >> $HOME/.zshrc
echo 'fpath+=~/.oh-my-zsh/custom/plugins/zsh-completions/src' >> $HOME/.zshrc

echo 'zsh' >> $HOME/.bashrc

sed -ri 's/^#PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

systemctl enable ssh
systemctl enable cron

for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
apt-get install ca-certificates gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

systemctl enable docker
apt install docker-compose -y
source ~/.zshrc