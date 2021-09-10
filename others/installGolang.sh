#!/bin/bash
#
# 一键安装最新版的Golang
# 

filename=`curl -s https://golang.org/dl/ | grep downloadBox | grep linux | awk -F'/dl/' '{print $2}' | awk -F'\">' '{print $1}'`

wget -P /root/ https://golang.org/dl/${filename}

tar -zxvf /root/${filename} -C  /usr/local/

echo "PATH=$PATH:$HOME/bin:/usr/local/go/bin" >> /etc/profile

echo "export PATH" >> /etc/profile

source /etc/profile