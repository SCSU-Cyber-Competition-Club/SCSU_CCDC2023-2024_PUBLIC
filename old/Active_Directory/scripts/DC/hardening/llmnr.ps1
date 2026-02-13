# Link Local Multicast Name Resolution is a legacy protocol for resolving hostnames on a network; DNS performs this function,
# without LLMNR's vulnerabilities to poisoning attacks (similar to NBT-NS poisoning).
Write-Host "Disabling LLMNR..." -ForeGroundColor Red
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0
Write-Host "LLMNR disabled." -ForeGroundColor Red

