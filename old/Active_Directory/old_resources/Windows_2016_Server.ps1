# Disable SMBv1 protocol
Set-SmbServerConfiguration -EnableSMB1Protocol $false

# Enable Windows Firewall and block unnecessary ports
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True
Set-NetFirewallRule -DisplayName "File and Printer Sharing (SMB-In)" -Enabled True
Set-NetFirewallRule -DisplayName "Remote Desktop - User Mode (TCP-In)" -Enabled True
Set-NetFirewallRule -DisplayName "Windows Remote Management (HTTP-In)" -Enabled True
Set-NetFirewallRule -DisplayName "Windows Remote Management (HTTPS-In)" -Enabled True

# Enable Windows Defender and update definitions
Set-MpPreference -DisableRealtimeMonitoring $false
Update-MpSignature

# Install the latest Windows updates
$WindowsUpdateSession = New-Object -ComObject Microsoft.Update.Session
$WindowsUpdateSearcher = $WindowsUpdateSession.CreateUpdateSearcher()
$SearchResult = $WindowsUpdateSearcher.Search("IsInstalled=0")
$UpdatesToInstall = $SearchResult.Updates | Where-Object { $_.IsHidden -eq $false }
$Installer = $WindowsUpdateSession.CreateUpdateInstaller()
$Installer.Updates = $UpdatesToInstall
$Installer.Install()

# Configure strong password policies
$PasswordPolicy = Get-WmiObject -Class Win32_AccountPolicy -Namespace "root\rsop\computer" | Where-Object { $_.Caption -eq "Password Policy" }
$PasswordPolicy.MinimumPasswordLength = 16
$PasswordPolicy.MaxPasswordAge = (New-TimeSpan -Days 90).TotalSeconds
$PasswordPolicy.PasswordComplexity = $true
$PasswordPolicy.Put()

# Enable auditing for critical events
$AuditPolicy = Get-WmiObject -Class Win32_AuditPolicy -Namespace "root\rsop\computer" | Where-Object { $_.Caption -eq "Audit Policy" }
$AuditPolicy.AuditLogonEvents = 3
$AuditPolicy.AuditAccountLogonEvents = 3
$AuditPolicy.AuditPolicyChangeEvents = 3
$AuditPolicy.Put()

# Disable unnecessary services
$ServicesToDisable = @(
    "Telnet",
    "FTP",
    "SNMP",
    "Remote Registry",
    "NetMeeting Remote Desktop Sharing",
    "Print Spooler"
)
foreach ($Service in $ServicesToDisable) {
    Set-Service -Name $Service -StartupType Disabled
}

# Enable Windows Defender Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# Restart the server to apply changes
Restart-Computer -Force
