# When a lockout policy is enabled through Group Policy, it does NOT apply to administrator accounts, unless Admin Lockout is enabled. This doesn't show up sometime in
#GP... but enabling it via Registry should get ya set either way. (Your Group Policy Editor is mostly a glorified GUI for editing Registry keys.)
Write-Host "Enabling admin lockout..." -ForeGroundColor Red
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableAdminAccountLock" -Value 1
Write-Host "Admin lockout enabled." -ForeGroundColor Red

