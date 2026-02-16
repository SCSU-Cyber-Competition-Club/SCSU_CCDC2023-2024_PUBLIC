# Firewall

#### Enable firewall

`sudo systemctl enable --now firewalld`

#### Reload firewall

`sudo firewall-cmd --reload`

#### Create a new firewall zone

`sudo firewall-cmd --new-zone FedoraServer --permanent`

#### Set default firewall zone

`sudo firewall-cmd --set-default FedoraServer`

#### Allow port through the firewall

`sudo firewall-cmd --add-port 1622/tcp --permanent`

#### Allow service through the firewall


`sudo firewall-cmd --add-service smtp --permanent`

`sudo firewall-cmd --add-service pop3 --permanent`

`sudo firewall-cmd --add-service imap --permanent`

`sudo firewall-cmd --add-service smtp --permanent`

`sudo firewall-cmd --add-service dns --permanent`

`sudo firewall-cmd --add-service icmp --permanent`

`sudo firewall-cmd --add-service httpd --permanent`

#### Show firewall zone configuration

`sudo firewall-cmd --zone FedoraServer --list-all`


### [firewall-cmd info](https://www.redhat.com/sysadmin/secure-linux-network-firewall-cmd)
**
