# Hysteria

### [Hysteria 2 官方文档](https://v2.hysteria.network/zh/)

### server：

```dockerfile
#一键安装Hysteria2
bash <(curl -fsSL https://get.hy2.sh/)

#生成自签证书
openssl req -x509 -nodes -newkey ec:<(openssl ecparam -name prime256v1) -keyout /etc/hysteria/server.key -out /etc/hysteria/server.crt -subj "/CN=bing.com" -days 36500 && sudo chown hysteria /etc/hysteria/server.key && sudo chown hysteria /etc/hysteria/server.crt

#配置config.yaml（CA/自签二选一）
cat << EOF > /etc/hysteria/config.yaml
listen: :443 #监听端口

#使用CA证书
#acme:
#  domains:
#    - a.com #你的域名，需要先解析到服务器ip
#  email: test@sharklasers.com  #真实或错误都可

#使用自签证书
#tls:
#  cert: /etc/hysteria/server.crt
#  key: /etc/hysteria/server.key

auth:
  type: password
  password: 123456 #设置认证密码
  
masquerade:
  type: proxy
  proxy:
    url: https://bing.com #伪装网址
    rewriteHost: true
EOF

#启动Hysteria2
systemctl start hysteria-server.service
#重启Hysteria2
systemctl restart hysteria-server.service
#查看Hysteria2状态
systemctl status hysteria-server.service
#停止Hysteria2
systemctl stop hysteria-server.service
#设置开机自启
systemctl enable hysteria-server.service
#查看日志
journalctl -u hysteria-server.service
```

![image-20231114172322160](/Users/nnxs/Library/Application Support/typora-user-images/image-20231114172322160.png)

### client：（根据系统选择对应[版本](https://github.com/apernet/hysteria/releases)）

```bash
#此处假设macOS
mkdir hysteria
mv ~/Downloads/hysteria-darwin-arm64 ~/hysteria/hysteria-darwin-arm64
chmod +x hysteria-darwin-arm64
vim config.yaml

#设置config.yaml（server没设置带宽，则以client为准，否则client_up=min(server_down, client_up), client_down=min(server_up, client_down)）
server: ip:443
auth: 123456

bandwidth:
  up: 20 mbps
  down: 100 mbps
  
tls:
  sni: a.com
  insecure: false #使用自签时需要改成true

socks5:
  listen: 127.0.0.1:1080
http:
  listen: 127.0.0.1:8080
```

```bash
./hysteria-darwin-arm64
```

![image-20231114171717020](/Users/nnxs/Library/Application Support/typora-user-images/image-20231114171717020.png)

