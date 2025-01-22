Set-ADDefaultDomainPasswordPolicy -MinPasswordLength 8
Write-Host "Password minimum GPO set to 8 characters."

Set-ADDefaultDomainPasswordPolicy -ComplexityEnabled $true
Write-Host "Password complexity GPO enabled."

Set-ADDefaultDomainPasswordPolicy -LockoutThreshold 5 -LockoutDuration 60 -LockoutCounterReset 15
Write-Host "Account lockout policy set. 5 attempts, 60 minute lockout, 15 minute counter reset time."

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableAdminAccountLock" -Value 1
Write-Host "Lockout of administrator accounts enabled."

Set-ADDefaultDomainPasswordPolicy -StorePasswordUsingReversibleEncryption $false
Write-Host "Reversible encryption use for passwords disabled."

# Ensure AES256 encryption is used for Kerberos.
# THIS WILL ONLY FORCE AES256 IF NO OTHER VALUES ARE PRESENT HERE, which is the case in the 2025 comp.
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters" -Name "SupportedEncryptionTypes" -Value 0x8
