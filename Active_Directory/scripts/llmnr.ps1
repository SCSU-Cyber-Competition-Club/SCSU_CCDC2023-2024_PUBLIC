Write-Host "Disabling LLMNR..." -ForeGroundColor Red
Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "EnableMulticast" -Value 0
Write-Host "LLMNR disabled." -ForeGroundColor Red
