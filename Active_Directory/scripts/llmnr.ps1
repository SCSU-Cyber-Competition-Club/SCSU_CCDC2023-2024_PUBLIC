Write-Host "Disabling LLMNR..." -ForeGroundColor Red


Set-ItemProperty -Path "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name "NetbiosOptions" -Value 0 -Type Dword
Write-Host "LLMNR disabled." -ForeGroundColor Red
