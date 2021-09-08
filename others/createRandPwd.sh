#!/bin/bash
#
# 创建没有歧义的随机密码
# 无1ilIoO0
#

openssl rand -base64 32 | sed 's/l//g;s/i//g;s/I//g;s/o//g;s/O//g;s/0//g;s/\///g;s/+//g;' | cut -b 1-10
