# PowerShell Script to block traffic from a malicious IP address

# Prompt user for the malicious IP
$maliciousIP = Read-Host "Which mole we whackin'? (Enter the malicious IP.)"

# Block inbound traffic
New-NetFirewallRule -DisplayName "Red team inbound ($maliciousIP)" `
    -Direction Inbound `
    -Action Block `
    -RemoteAddress $maliciousIP `
    -Profile Any `
    -Enabled True

# Block outbound traffic
New-NetFirewallRule -DisplayName "Red team outbound ($maliciousIP)" `
    -Direction Outbound `
    -Action Block `
    -RemoteAddress $maliciousIP `
    -Profile Any `
    -Enabled True

Write-Host "Mole whacked." -ForeGroundColor Red
