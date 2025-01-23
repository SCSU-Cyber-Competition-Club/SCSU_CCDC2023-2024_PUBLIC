#! /bin/bash

#move this file to home directory!!

#installing dependencies
yum install git
yum install python3
pip3 install ansi2html


#add ansi2html to the PATH

export PATH=$PATH:/usr/local/bin/
#Firewall Rules

#firewall inputs

systemctl enable --now firewalld

ifconfig

read -p "Enter Internal Interface: " intInterface
read -p "Enter External Interface: " extInterface

#resetting firewall to default settings
firewall-cmd --zone=public --remove-service=ssh --permanent
firewall-cmd --zone=public --remove-service=dhcpv6-client --permanent
firewall-cmd --get-default-zone
firewall-cmd --zone=trusted --add-interface=$intInterface --permanent
firewall-cmd --zone=public --add-interface=$extInterface --permanent

#setting http and https to be passed through the public interface
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent

#allowing splunk forwarder (this has changed to port 8000)
firewall-cmd --zone=public --add-port=8000/tcp --permanent

#allow time network protocols
firewall-cmd --zone=public --add-port=123/udp --permanent
firewall-cmd --zone=public --add-port=323/udp --permanent

#allowing DNS
firewall-cmd --zone=public --add-service=dns --permanent

#allowing NTP
firewall-cmd --zone=public --add-service=ntp --permanent

#allowing ICMP requests
firewall-cmd --zone=public --add-icmp-block=echo-request --permanent

#allowing local MariaDB connections
firewall-cmd --zone=trusted --add-port=3306/tcp --permanent

#reloading firewall rules to apply them
firewall-cmd --reload

#listing current firewall rules
firewall-cmd --list-all --zone=trusted
firewall-cmd --list-all --zone=public

#disabling ipv6 traffic. 
echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf
sysctl -p

echo 'This should not include ipv6 info:'
ip a | grep inet6


#removing ssh
chkconfig sshd off
service sshd stop
yum remove ssh
yum remove telnet
yum remove openssh-server
yum remove cockpit

#installing and running lynis
git clone https://github.com/CISOfy/lynis
cd lynis && ./lynis audit system | ansi2html -la > ../report.html
cd ..

#cleaning up after python3 install
yum remove python3

#listing installed packages

yum list installed > installed_packages.txt

#Apache Hardening
#need to add to this
yum install mod_security
yum install mod_ssl
#Checking sudoers
echo "Users in wheel group:"
getent group wheel | cut -d: -f4 | tr ',' '\n'


#finishing script
echo -e 'Remember to run:\n netstat -plant\n netstat-planu\n top(htop, btop)\n crontab -l [user]\n systemctl --type=service\n jobs -p (shows current jobs)\n check /etc/hosts file'

# Need to add installation for mod_security for apache

#Next adds will all be for apache hardening.
