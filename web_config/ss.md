# shadowsocks（裸ss很容易被墙）

### 一、原理

![image-20231201232044010](/Users/nnxs/Library/Application Support/typora-user-images/image-20231201232044010.png)

### 二、server

```bash
# 拉shadowsocks的docker，配置相应参数，此处开放端口11111（默认加密算法为aes-256-gcm）
$ docker run -e PASSWORD=123456 -p 11111:8388 -p 11111:8388/udp -d --restart always shadowsocks/shadowsocks-libev
```

```bash
# 使用frp实现内网穿透，server的11111端口映射到aliyun服务器11111端口，此处sercer做frp的客户端（可省）

# 下载压缩包
wget https://github.com/fatedier/frp/releases/download/v0.51.2/frp_0.51.2_linux_amd64.tar.gz

# 解压，重命名
tar -xzvf frp_0.51.2_linux_amd64.tar.gz
rm -rf frp_0.51.2_linux_amd64.tar.gz
mv frp_0.51.2_linux_amd64 frp

# 配置frpc.ini
[common]
server_addr = xxxxxx  # aliyun ip
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 11111
remote_port = 11111

# 启动client
./frpc -c ./frpc.ini
```

### 三、aliyun服务器（可省frp，client的server ip直接改为vps ip即可，容易被墙）

墙的原理：GFW重放攻击，某种方式直接发现vps在运行ss服务端，墙掉

```bash
# 开放11111端口（安全组配置，也可以同步修改frp client中的remote_port换其他端口），并启动frp server
./frps -c ./frps.ini
```

### 四、client

```bash
# 配置clash文件，使用ss协议，设置服务器ip、端口、加密类型、密码等
allow-lan: true
mode: rule
log-level: info
ipv6: true

proxies:
  - name: test
    type: ss
    server: xxxxxx  # aliyun ip
    port: 11111
    cipher: aes-256-gcm
    password: 123456
    udp: true

proxy-groups:
  - name: "PROXY"
    type: select
    proxies:
     - test

rules:
  - MATCH,PROXY
```

