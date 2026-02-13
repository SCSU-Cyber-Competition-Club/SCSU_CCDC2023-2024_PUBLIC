Write-Host "Building firewall..." -ForeGroundColor Red

# Risky services that can be blocked netcon-wise outright without causing issues in our environment.
New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Outbound -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any
New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Inbound -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any

New-NetFirewallRule -DisplayName "Block RDP"  -Direction Outbound  -Protocol Any -Action Block  -Service "TermService"  -Profile Any
New-NetFirewallRule -DisplayName "Block RDP"  -Direction Inbound  -Protocol Any -Action Block  -Service "TermService"  -Profile Any

New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Outbound -Protocol Any -Action Block  -Service "winrm"  -Profile Any
New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Inbound  -Protocol Any -Action Block  -Service "winrm"  -Profile Any

New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Outbound -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any
New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Inbound  -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any





# 135: RPC (Remote Procedure Call), 137: NetBIOS, 139: SMB over NetBIOS, 445: SMB
# The above four are dangerous ports, especially with Zerologon (which our system won't/can't have received the patch for);
# However, as a domain controller, your system NEEDS to send data OUT to the domain through these ports.
# In our environment (especially considering there's only one domain controller), this traffic can be blocked INBOUND without interfering with scoring.
New-NetFirewallRule -DisplayName "Block 135 TCP (Inbound only)"  -Direction Inbound  -Protocol TCP  -LocalPort 135 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 137 TCP (Inbound only)"  -Direction Inbound  -Protocol TCP  -LocalPort 137 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 139 TCP (Inbound only)"  -Direction Inbound  -Protocol TCP  -LocalPort 139 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 445 TCP (Inbound only)"  -Direction Inbound  -Protocol TCP  -LocalPort 445 -Action Block -Profile Any

#New-NetFirewallRule -DisplayName "Block HTTP TCP (Inbound only)"  -Direction Inbound  -Protocol TCP -Action Block  -LocalPort 80  -Profile Any

#New-NetFirewallRule -DisplayName "Block HTTPS TCP (Inbound only)"  -Direction Inbound  -Protocol TCP -Action Block  -LocalPort 443  -Profile Any


New-NetFirewallRule -DisplayName "Block 135 UDP (Inbound only)"  -Direction Inbound  -Protocol UDP  -LocalPort 135 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 137 UDP (Inbound only)"  -Direction Inbound  -Protocol UDP  -LocalPort 137 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 139 UDP (Inbound only)"  -Direction Inbound  -Protocol UDP  -LocalPort 139 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 445 UDP (Inbound only)"  -Direction Inbound  -Protocol UDP  -LocalPort 445 -Action Block -Profile Any

#New-NetFirewallRule -DisplayName "Block HTTP UDP (Inbound only)"  -Direction Inbound  -Protocol UDP -Action Block  -LocalPort 80  -Profile Any

#New-NetFirewallRule -DisplayName "Block HTTPS UDP (Inbound only)"  -Direction Inbound  -Protocol UDP -Action Block  -LocalPort 443  -Profile Any

#YOU SHOULD PROBABLY UNCOMMENT THESE TWO! Kerberos authentication ports. I only have them commented out as I didn't get a chance to test them
#myself in our competition, so I can't verify things won't break.
#Once you have access to the environment, uncomment it, test it, make sure it works.
#New-NetFirewallRule -DisplayName "Block 88 TCP (Inbound only)"  -Direction Inbound  -Protocol TCP  -LocalPort 88 -Action Block -Profile Any
#New-NetFirewallRule -DisplayName "Block 88 UDP (Inbound only)"  -Direction Inbound  -Protocol UDP  -LocalPort 88 -Action Block -Profile Any

# Creating rules for a firewall doesn't mean the firewall is enabled. In previous competitions, the firewalls have been disabled initially.
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

Write-Host "Firewall built (and enabled)."-ForeGroundColor Red

