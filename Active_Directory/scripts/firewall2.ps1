Write-Host "Building firewall..." -ForeGroundColor Red

New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Outbound -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any
New-NetFirewallRule -DisplayName "Block Telnet"  -Direction Inbound -Protocol Any -Action Block  -Service "Tlntsvr"  -Profile Any

New-NetFirewallRule -DisplayName "Block RDP"  -Direction Outbound  -Protocol Any -Action Block  -Service "TermService"  -Profile Any
New-NetFirewallRule -DisplayName "Block RDP"  -Direction Inbound  -Protocol Any -Action Block  -Service "TermService"  -Profile Any

New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Outbound -Protocol Any -Action Block  -Service "winrm"  -Profile Any
New-NetFirewallRule -DisplayName "Block WinRM"  -Direction Inbound  -Protocol Any -Action Block  -Service "winrm"  -Profile Any

New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Outbound -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any
New-NetFirewallRule -DisplayName "Block SSDP"  -Direction Inbound  -Protocol Any -Action Block  -Service "ssdpsrv"  -Profile Any






New-NetFirewallRule -DisplayName "Block 135 (Inbound only)"  -Direction Inbound  -Protocol Any  -LocalPort 135 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 137 (Inbound only)"  -Direction Inbound  -Protocol Any  -LocalPort 137 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 139 (Inbound only)"  -Direction Inbound  -Protocol Any  -LocalPort 139 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block 445 (Inbound only)"  -Direction Inbound  -Protocol Any  -LocalPort 445 -Action Block -Profile Any

New-NetFirewallRule -DisplayName "Block HTTP (Inbound only)"  -Direction Inbound  -Protocol Any -Action Block  -LocalPort 80  -Profile Any

New-NetFirewallRule -DisplayName "Block HTTPS (Inbound only)"  -Direction Inbound  -Protocol Any -Action Block  -LocalPort 443  -Profile Any

Write-Host "Firewall built."-ForeGroundColor Red
Write-Host "Don't forget to ensure the firewall is manually enabled!" -ForeGroundColor Green