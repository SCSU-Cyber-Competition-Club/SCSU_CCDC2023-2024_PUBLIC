﻿Write-Host "Building firewall..." -ForeGroundColor Red

# Risky services that can be blocked netcon-wise outright without causing issues in our environment.
New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Outbound -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any
New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Inbound -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any

New-NetFirewallRule -DisplayName "Block RDP"  -Direction Outbound  -Protocol Any -Action Block  -Service "TermService"  -Profile Any
New-NetFirewallRule -DisplayName "Block RDP"  -Direction Inbound  -Protocol Any -Action Block  -Service "TermService"  -Profile Any

New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Outbound -Protocol Any -Action Block  -Service "winrm"  -Profile Any
New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Inbound  -Protocol Any -Action Block  -Service "winrm"  -Profile Any

New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Outbound -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any
New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Inbound  -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any


New-NetFirewallRule -DisplayName "Block HTTP TCP (Inbound only)"  -Direction Inbound  -Protocol TCP -Action Block  -LocalPort 80  -Profile Any

New-NetFirewallRule -DisplayName "Block HTTPS TCP (Inbound only)"  -Direction Inbound  -Protocol TCP -Action Block  -LocalPort 443  -Profile Any




New-NetFirewallRule -DisplayName "Block 445 UDP (Inbound only)"  -Direction Inbound  -Protocol UDP  -LocalPort 445 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block HTTP UDP (Inbound only)"  -Direction Inbound  -Protocol UDP -Action Block  -LocalPort 80  -Profile Any

New-NetFirewallRule -DisplayName "Block HTTPS UDP (Inbound only)"  -Direction Inbound  -Protocol UDP -Action Block  -LocalPort 443  -Profile Any


# Creating rules for a firewall doesn't mean the firewall is enabled. In previous competitions, the firewalls have been disabled initially.
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

Write-Host "Firewall built (and enabled)."-ForeGroundColor Red
