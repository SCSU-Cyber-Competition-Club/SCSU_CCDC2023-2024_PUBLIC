```
set deviceconfig system type static

set deviceconfig system ip-address <ip address> netmask <netmask> default-gateway <default gateway> dns-setting servers primary <DNS ip address>
```
show interface management

[https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClN7CAK](https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClN7CAK)


To view the settings of IP address, DNS etc, Use "show deviceconfig system" command in the configuration mode.

admin@Lab-VM> **set cli config-output-format set**
admin@Lab-VM> **configure**
Entering configuration mode
[edit]
admin@Lab196-97-PA-VM# show deviceconfig system
set deviceconfig system ip-address 10.46....
set deviceconfig system netmask 255.255.255.192
set deviceconfig system update-server updates.paloaltonetworks.com
.......
set deviceconfig system default-gateway 10.46....
set deviceconfig system dns-setting servers primary 8.8.8.8
set deviceconfig system dns-setting servers secondary 4.2.2.1
.....
[edit]
admin@Lab-VM# **exit**
Exiting configuration mode






Show system info
`show system info`

Shutdown
`request shutdown system`

Restart
`request restart system`

Commit changes
`commit`

Save config
`save config`



### Setting up the management interface

`configure`

`set deviceconfig system type static`

`set deviceconfig system ip-address <IP_ADDRESS> netmask <NETMASK> default-gateway <GATEWAY>`

`set deviceconfig system dns-setting servers primary <PRIMARY_DNS> secondary <SECONDARY_DNS>`

`commit`



https://www.youtube.com/watch?v=Al5by-_8R3Y



1/1 pub 241
1/2 int 240
1/4 user 242