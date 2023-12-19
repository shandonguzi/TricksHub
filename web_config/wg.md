# wireguard+clash

### wireguard配置：

```dockerfile
services:
  wg:
    restart: always
    build: wg
    ports:
      - 51820:51820/udp
      - 51821:51821/tcp
    volumes:
      - type: bind
        source: wg/.wg-easy
        target: /etc/wireguard
    cap_add:
      - "NET_ADMIN"
      - "SYS_MODULE"
    sysctls: ["net.ipv4.conf.all.src_valid_mark=1", "net.ipv4.ip_forward=1"]
    environment:
      - WG_HOST=xxx
      - WG_PORT=51820
      - WG_DEFAULT_DNS=
      - PORT=51821
      - PASSWORD=xxx
      - WG_DEFAULT_ADDRESS=10.9.3.x
      - WG_ALLOWED_IPS=10.9.3.0/24
      - WG_PERSISTENT_KEEPALIVE=25
    container_name: wg
```

### Plan 1：wireguard组局域网，挂代理访问clash服务端（后续将这些步骤写到dockerfile里）

```bash
# clash服务端（此处为搬瓦工的wg-easy container）
docker exec -it wg-easy bash

# 安装vim、screen，下载clash安装包
apk update && apk add vim screen
wget https://github.com/Dreamacro/clash/releases/download/v1.17.0/clash-linux-386-v1.17.0.gz
gunzip clash-linux-386-v1.17.0.gz
mv clash-linux-386-v1.17.0 /usr/bin/clash
chmod +x /usr/bin/clash
clash  # 执行后断掉生成配置文件
cd ~/.config/clash
vim config.yaml  # 配置如下

mixed-port: 7890
allow-lan: true

# 开screen
screen -S clash
clash
```

```bash
# clash客户端开wireguard，clash配置如下
allow-lan: true  # 允许lan监听，而不仅仅是本机
mode: rule
log-level: info
ipv6: true

proxies:
  - name: test
    type: http
    server: 10.8.0.111
    port: 7890

proxy-groups:
  - name: "PROXY"
    type: select
    proxies:
     - test

rules:
  - MATCH,PROXY
```

### Plan2：wireguard组局域网，clash服务端配置如上，阿里云做clash客户端（其他终端的clash服务端）

```bash
# clash服务端（此处为搬瓦工的wg-easy container）
docker exec -it wg-easy bash

# 安装vim、screen，下载clash安装包
apk update && apk install vim screen
wget https://github.com/Dreamacro/clash/releases/download/v1.17.0/clash-linux-386-v1.17.0.gz
gunzip clash-linux-386-v1.17.0.gz
mv clash-linux-386-v1.17.0 /usr/bin/clash
chmod +x /usr/bin/clash
clash  # 执行后断掉生成配置文件
cd ~/.config/clash
vim config.yaml  # 配置如下

mixed-port: 7890
allow-lan: true

# 开screen
screen -S clash
clash
```

```bash
# clash客户端（此处为阿里云服务器）开wireguard，clash配置如下
allow-lan: true
mode: rule
log-level: info
ipv6: true
mixed-port: 6666

proxies:
  - name: test
    type: http
    server: 10.8.0.111  # 搬瓦工wg-easy container的ip
    port: 7890

proxy-groups:
  - name: "PROXY"
    type: select
    proxies:
     - test

rules:
  - MATCH,PROXY
```

客户端连接任意网络，只需配置代理（ip：阿里云服务器，port：6666）

！！不需要其他设置即可科学上网，但受限于阿里云的带宽



**Problem1**：存在封端口的情况（仅wireguard、clash使用http代理就会被封），具体情况为，连接持续1～2天后国内无法科学上网，印证端口被封依据，目标使用nc -u建立udp对话通道，实现实时udp通信，其他端口都可，被封端口只能实现国内到国外，无法实现国外到国内

```bash
# bandwagon
nc -u localhost xxxx

# mac / aliyun
nc -u bandwagon_ip xxxx
```

（应该是Plan1的问题，建议使用Plan2）

**Problem2**：wg0.conf文件中的server地址是10.0.0.1，但容器的wg地址为10.0.0.111（人为设置），且每次改动wg0.conf，一运行其他设备，wg0.conf文件中的server地址就变为10.0.0.1
