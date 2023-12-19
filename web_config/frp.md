# frp——最基础的内网穿透

### 一、server

```bash
# 下载压缩包
wget https://github.com/fatedier/frp/releases/download/v0.51.2/frp_0.51.2_linux_amd64.tar.gz

# 解压，重命名
tar -xzvf frp_0.51.2_linux_amd64.tar.gz
rm -rf frp_0.51.2_linux_amd64.tar.gz
mv frp_0.51.2_linux_amd64 frp

# 运行server
cd frp
./frps -c ./frps.ini
```

### 二、client

```bash
# 下载压缩包
wget https://github.com/fatedier/frp/releases/download/v0.51.2/frp_0.51.2_linux_amd64.tar.gz

# 解压，重命名
tar -xzvf frp_0.51.2_linux_amd64.tar.gz
rm -rf frp_0.51.2_linux_amd64.tar.gz
mv frp_0.51.2_linux_amd64 frp

# 配置frpc.ini
[common]
server_addr = xxxxxx
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = xxx
remote_port = xxx

# 启动client
./frpc -c ./frpc.ini
```

### 三、远程登录

```bash
ssh root@xxxxxx -oPort=remote_port
```

