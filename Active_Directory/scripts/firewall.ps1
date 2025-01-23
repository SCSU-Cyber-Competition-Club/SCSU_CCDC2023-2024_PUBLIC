#First block of rules serve to allow communication between OUR machines using services that are dangerous, but necessary for functionality.
#Second block of rules implicitly deny connections using these necessary-but-dangerous services. These rules will be superceded by the first block for
#communications between our endpoints.
#Third block of rules implicitly denies dangerous services we don't need.
#Blocking by SERVICE is necessary, as attackers can alter ports used to bypass port-based firewall rules. Likewise, the first block will specify the
#typical ports for that service to be allowed, but the blocking rules will not (not providing parameters for -localport or -remoteport defaults to Any).

#Please, for the love of god, don't do what I did here with the IPs. This file would be half the size if I used a variable for those remote IPs...



#New-NetFirewallRule -DisplayName "Allow WinRM Outbound" -Direction Inbound -Protocol TCP -LocalPort 5895,5896 ` -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150" -Action Allow -Service "winrm" ` -Profile Any
#New-NetFirewallRule -DisplayName "Allow WinRM Inbound" -Direction Inbound -Protocol TCP -LocalPort 5895,5896 ` -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150" -Action Allow -Service "winrm" ` -Profile Any



New-NetFirewallRule -DisplayName "Allow SSHTCP Outbound"  -Direction Outbound  -Protocol TCP  -LocalPort 22  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "sshd"  -Profile Any
New-NetFirewallRule -DisplayName "Allow SSHTCP Inbound"  -Direction Inbound  -Protocol TCP  -LocalPort 22 -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "sshd"  -Profile Any
New-NetFirewallRule -DisplayName "Allow SSHUDP Outbound"  -Direction Outbound  -Protocol UDP  -LocalPort 22 -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "sshd"  -Profile Any
New-NetFirewallRule -DisplayName "Allow SSHUDP Inbound"  -Direction Inbound  -Protocol UDP  -LocalPort 22 -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "sshd"  -Profile Any

New-NetFirewallRule -DisplayName "Allow HTTP Outbound"  -Direction Outbound  -Protocol TCP  -LocalPort 80  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "http"  -Profile Any
New-NetFirewallRule -DisplayName "Allow HTTP Inbound"  -Direction Inbound  -Protocol TCP  -LocalPort 80  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "http"  -Profile Any

New-NetFirewallRule -DisplayName "Allow KerberosTCP Outbound"  -Direction Outbound  -Protocol TCP  -LocalPort 88  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "krb5"  -Profile Any
New-NetFirewallRule -DisplayName "Allow KerberosTCP Inbound"  -Direction Inbound  -Protocol TCP  -LocalPort 88  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "krb5"  -Profile Any
New-NetFirewallRule -DisplayName "Allow KerberosUDP Outbound"  -Direction Outbound  -Protocol UDP  -LocalPort 88  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "krb5"  -Profile Any
New-NetFirewallRule -DisplayName "Allow KerberosUDP Inbound"  -Direction Inbound  -Protocol UDP  -LocalPort 88  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "krb5"  -Profile Any

New-NetFirewallRule -DisplayName "Allow RPC/WMI Outbound"  -Direction Outbound  -Protocol TCP  -LocalPort 135  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "rpcss"  -Profile Any
New-NetFirewallRule -DisplayName "Allow RPC/WMI Inbound"  -Direction Inbound  -Protocol TCP  -LocalPort 135  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "rpcss,winmgmt"  -Profile Any

New-NetFirewallRule -DisplayName "Allow KerbPass Outbound"  -Direction Outbound  -Protocol Any  -LocalPort 464  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "kpasswd"  -Profile Any
New-NetFirewallRule -DisplayName "Allow KerbPass Inbound"  -Direction Inbound  -Protocol Any  -LocalPort 464  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "kpasswd"  -Profile Any

New-NetFirewallRule -DisplayName "Allow LDAP Outbound"  -Direction Outbound  -Protocol Any  -LocalPort 389  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "ldap"  -Profile Any
New-NetFirewallRule -DisplayName "Allow LDAP Inbound"  -Direction Inbound  -Protocol Any  -LocalPort 389  -RemoteAddress "172.20.240.10,172.20.240.20,172.20.242.10,172.20.242.200,172.20.241.20,172.20.241.30,172.20.241.40,172.20.242.150"  -Action Allow  -Service "ldap"  -Profile Any


#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Realized at this point you can make one rule for both inbound and outbound with -Direction Both. Not taking the time to clean up the code above, even though I'm taking the time to write this comment. Deal with it.


New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Both  -Protocol Any -Action Block  -Service "winrm"  -Profile Any
New-NetFirewallRule -DisplayName "Block WMI"  -Direction Both  -Protocol Any -Action Block  -Service "winmgmt"  -Profile Any
New-NetFirewallRule -DisplayName "Block RPC"  -Direction Both  -Protocol Any -Action Block  -Service "rpcss"  -Profile Any


New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Both  -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any


New-NetFirewallRule -DisplayName "Block SSH"  -Direction Both  -Protocol Any -Action Block  -Service "sshd"  -Profile Any

#ASK/TEST!!!!!!!!
New-NetFirewallRule -DisplayName "Block HTTP"  -Direction Both  -Protocol Any -Action Block  -Service "http"  -Profile Any

New-NetFirewallRule -DisplayName "Block Kerberos"  -Direction Both  -Protocol Any -Action Block  -Service "Kerb5"  -Profile Any

New-NetFirewallRule -DisplayName "Block RPC"  -Direction Both  -Protocol Any -Action Block  -Service "Rpcss"  -Profile Any

New-NetFirewallRule -DisplayName "Block Kerb Pass Changes"  -Direction Both  -Protocol Any -Action Block  -Service "kpasswd"  -Profile Any

New-NetFirewallRule -DisplayName "Block LDAP"  -Direction Both  -Protocol Any -Action Block  -Service "ldap"  -Profile Any

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

New-NetFirewallRule -DisplayName "Block RDP"  -Direction Both  -Protocol Any -Action Block  -Service "TermService"  -Profile Any

New-NetFirewallRule -DisplayName "Block SMB"  -Direction Both  -Protocol Any -Action Block  -Service "LanManServer"  -Profile Any
New-NetFirewallRule -DisplayName "Block FTP"  -Direction Both  -Protocol Any -Action Block  -Service "ftpsvc"  -Profile Any


New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Both  -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any

#Following rule blocks port 593, which is RPC over HTTPS (RPC is needed, but not this). We already have restrictions for RPC above, but can't hurt.
New-NetFirewallRule -DisplayName "Block RPC thru HTTPS"  -Direction Both  -Protocol Any -Action Block  -LocalPort 593  -Profile Any


#The following rules aim at blocking VNC traffic. There is no single VNC service - many iterations exist. As such, these rules will use file paths
#for the various executable versions of VNC, as well as blocking the common port. (Again, as attackers may maliciously alter their port used, only the local port is specified.)
New-NetFirewallRule -Name "Block VNC Port" -DisplayName "Block Remote Desktop App (mstsc)" -LocalPort 5900 -Enabled True -Action Block
New-NetFirewallRule -Name "Block VNCTightServer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\TightVNC\tvnserver.exe" -Action Block
New-NetFirewallRule -Name "Block VNCTightViewer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\TightVNC\tvnviewer.exe" -Action Block
New-NetFirewallRule -Name "Block VNCRealServer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\RealVNC\vncserver.exe" -Action Block
New-NetFirewallRule -Name "Block VNCRealViewer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\RealVNC\vncviewer.exe" -Action Block
New-NetFirewallRule -Name "Block VNCUltraServer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\UltraVNC\winvnc.exe" -Action Block
New-NetFirewallRule -Name "Block VNCUltraViewer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\UltraVNC\vncviewer.exe" -Action Block
New-NetFirewallRule -Name "Block VNCTigerServer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\TigerVNC\vncserver.exe" -Action Block
New-NetFirewallRule -Name "Block VNCTigerViewer" -DisplayName "Block Remote Desktop App (mstsc)" -Enabled True -Program "C:\Program Files\TigerVNC\vncviewer.exe" -Action Block
