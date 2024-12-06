#!/usr/bin/env bash

read -p "Enter interface" interface
# Reset firewalld to default settings
firewall-cmd --complete-reload

# Set default policies to DROP
firewall-cmd --set-default-zone=drop

# Allow loopback communication
firewall-cmd --zone=trusted --add-interface=$interface
firewall-cmd --zone=trusted --add-interface=$interface --permanent

# Allow HTTP (port 80) and HTTPS (port 443)
firewall-cmd --zone=public --add-service=http
firewall-cmd --zone=public --add-service=https
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent

#Allow Splunk Forwarder (port 9997)
firewall-cmd --zone=public --add-port=9997/tcp --permanent

#Allow time network protocols
firewall-cmd --zone=public --add-port=123/udp --permanent
firewall-cmd --zone=public --add-port=323/udp --permanent

# Allow DNS (UDP)
firewall-cmd --zone=public --add-service=dns
firewall-cmd --zone=public --add-service=dns --permanent

# Allow NTP (UDP)
firewall-cmd --zone=public --add-service=ntp
firewall-cmd --zone=public --add-service=ntp --permanent

# Allow incoming ICMP (ping) requests
firewall-cmd --zone=public --add-icmp-block=echo-request
firewall-cmd --zone=public --add-icmp-block=echo-request --permanent

# Allow local MariaDB connections (on the loopback interface)
firewall-cmd --zone=trusted --add-port=3306/tcp 
firewall-cmd --zone=trusted --add-port=3306/tcp --permanent

# Reload firewalld to apply the rules
firewall-cmd --reload
