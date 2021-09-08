####################################
# 
# name:init
# function:init_linux
# author:SimonCao                   
# date:2020-01-02
#
#
###################################

#!/bin/bash

RED='\033[31m'
GREEN='\033[32m'
YEELOW='\033[33m'
END_COL='\033[0m'

permissive_SELINUX(){
	
	echo -e "${YELLOW}configuring SELINUX to permissive${END_COL}"	
	sed -i "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/sysconfig/selinux 
	sed -i "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config

}



configure_ssh(){

        echo -e "${YELLOW}configuring ssh${END_COL}"
	sed -i  "s/^#PasswordAuthentication/PasswordAuthentication/" /etc/ssh/sshd_config 
	sed -i  "/^PasswordAuthentication/s/yes/no/" /etc/ssh/sshd_config 
	sed -i  "/^PermitRootLogin/s/no/yes/" /etc/ssh/sshd_config
	echo "" >> /etc/ssh/sshd_config
	echo "UseDNS no" >> /etc/ssh/sshd_config
	echo "ClientAliveInterval 30" >> /etc/ssh/sshd_config
	echo "ClientAliveCountMax 5" >> /etc/ssh/sshd_config
	#systemctl restart sshd
	
}

install_software_redhat(){

        echo -e "${YELLOW}installing software for redhat${END_COL}"
	yum install epel-release
	yum -y install telnet net-snmp net-snmp-utils bwm-ng iftop iotop traceroute screen rsync openssh-clients curl wget vim pciutils bind-utils man ntpdate lsof mtr lvm2 lsof mtr sysstat
	yum -y install net-tools 

}

install_software_debian(){

	echo -e "${YELLOW}installing software for debian${END_COL}"	
	apt-get install -y snmpd snmp subversion screen vim traceroute curl 
	apt-get install -y language-pack-kde-en 
	apt-get install -y iotop bwm-ng iftop sshfs nmap
	apt-get install -y nfs-common rpcbind 
	apt-get install -y squashfs-tools lupin-casper
	
}

configure_bashrc_redhat(){
	
        echo -e "${YELLOW}configuring bashrc for redhat${END_COL}"
	echo "export TIME_STYLE=long-iso" >> ~/.bashrc
	echo "alias vi='vim'" >> ~/.bashrc
	echo "alias ll='ls -la --color'" >> ~/.bashrc
        echo "alias grep='grep --color'" >> ~/.bashrc
        echo "PS1='\[$(tput bold)\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\]-\[$(tput sgr0)\]\[\033[38;5;160m\]\A\[$(tput sgr0)\]:[\[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]\\$\[$(tput sgr0)\] '" >> ~/.bashrc
	echo "shopt -s histverify" >> ~/.bashrc
	source ~/.bashrc
	
}



configure_bashrc_debian(){
	
	echo -e "${YELLOW}configuring bashrc for debian${END_COL}"
        echo "PS1='\[$(tput bold)\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]\h\[$(tput sgr0)\]-\[$(tput sgr0)\]\[\033[38;5;160m\]\A\[$(tput sgr0)\]:[\[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]]\[$(tput sgr0)\]\\$\[$(tput sgr0)\] '" >> ~/.bashrc
	echo "export TIME_STYLE=long-iso" >> ~/.bashrc
        echo "alias mv='mv -i'" >> ~/.bashrc
	echo "alias cp='cp -i'" >> ~/.bashrc
        echo "alias rm='rm -i'" >> ~/.bashrc
        echo "LANG=en_US.UTF-8" >> ~/.bashrc
        echo "LC_ALL=en_US.UTF-8" >> ~/.bashrc
        echo "shopt -s histverify" >> ~/.bashrc
	source ~/.bashrc
	
}


init(){	
	
	permissive_SELINUX		
        configure_ssh 	
	if [[ -f /etc/debian_version ]]; then
		install_software_debian
		configure_bashrc_debian	
      	elif [[ -f /etc/redhat-release ]]; then
		install_software_redhat
		configure_bashrc_redhat
      	else
        	echo >&2  -e "${RED}Unidentifiable or unsupported platform."
        exit 1	
	fi
	echo -e "${GREEN}init completed"
	echo -e "${YELLOW}请确认正确添加ssh密钥后手动重启ssh服务${END_COL}"
}


init
