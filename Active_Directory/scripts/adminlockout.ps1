Write-Host "Enabling admin lockout..." -ForeGroundColor Red
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableAdminAccountLock" -Value 1
Write-Host "Admin lockout enabled." -ForeGroundColor Red

