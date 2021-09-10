#!/bin/bash
#
# 一键安装最新版的Golang
# 

read -p 'version: ' version

wget -P /root/ https://golang.org/dl/go${version}.linux-amd64.tar.gz 

tar -zxvf /root/linux-amd64.tar.gz -C > /usr/local/

echo "PATH=$PATH:$HOME/bin:/usr/local/go/bin" >> /etc/profile

echo "export PATH" >> /etc/profile