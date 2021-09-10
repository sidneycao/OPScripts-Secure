#!/bin/bash
#
# 一键安装最新版的Golang
# 

url=`curl -s https://golang.org/dl/ | grep downloadBox | grep linux | awk -F'=\"' '{print $3}' | awk -F'\">' '{print $1}'`

wget -P /root/ https://golang.org${url}

tar -zxvf /root/linux-amd64.tar.gz -C  /usr/local/

echo "PATH=$PATH:$HOME/bin:/usr/local/go/bin" >> /etc/profile

echo "export PATH" >> /etc/profile