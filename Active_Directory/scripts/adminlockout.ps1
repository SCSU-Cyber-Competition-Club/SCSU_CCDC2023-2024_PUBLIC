
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableAdminAccountLock" -Value 1
Write-Host "Lockout of administrator accounts enabled."

