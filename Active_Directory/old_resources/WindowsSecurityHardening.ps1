# Disable storing LM hash value on next password change
$lmHashPolicy = Get-WmiObject -Query "SELECT * FROM Win32_OperatingSystem" | ForEach-Object { $_.Version -eq '10.0.14393' }
if ($lmHashPolicy) {
    $lmHashPolicySetting = Get-WmiObject -Namespace root\cimv2 -Class Win32_AccountPolicy -Filter "Name='NewPassword'"
    $lmHashPolicySetting.SetPasswordHistory(0)
}

# Prompt user to press Enter before continuing
Read-Host "Press Enter to continue..."

# Enable SMB packet signing
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$registryName = "RequireSecuritySignature"
$registryValue = 1
New-ItemProperty -Path $registryPath -Name $registryName -Value $registryValue -PropertyType DWORD -Force

# Prompt user to press Enter before continuing
Read-Host "Press Enter to continue..."

# Enable Microsoft network server: Digitally sign communication (always)
$digitallySignPolicy = Get-WmiObject -Query "SELECT * FROM Win32_OperatingSystem" | ForEach-Object { $_.Version -eq '10.0.14393' }
if ($digitallySignPolicy) {
    $digitallySignSetting = Get-WmiObject -Namespace root\cimv2 -Class Win32_NetworkLoginProfile
    $digitallySignSetting.DigitallySignServerCommunication = 1
    $digitallySignSetting.Put()
}

# Prompt user to press Enter before continuing
Read-Host "Press Enter to continue..."

# Enable LDAP server signing requirements
$ldapSigningPolicy = Get-WmiObject -Query "SELECT * FROM Win32_OperatingSystem" | ForEach-Object { $_.Version -eq '10.0.14393' }
if ($ldapSigningPolicy) {
    $ldapSigningSetting = Get-WmiObject -Namespace root\cimv2 -Class Win32_DirectorySpecification
    $ldapSigningSetting.DSHeuristics = 1
    $ldapSigningSetting.Put()
}

# Final message
Write-Host "Security configurations applied successfully."
