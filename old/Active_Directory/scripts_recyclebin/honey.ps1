# Prompt the user for the honeypot file path
$honeypotFilePath = Read-Host "Please enter the path for your honeypot file (e.g., C:\path\to\honeypot\passwords.txt)"

# Ensure the file path is valid
if (-not (Test-Path -Path (Split-Path $honeypotFilePath))) {
    Write-Host "The directory does not exist. Please ensure the directory exists before proceeding."
    exit
}

# Prompt the user for the alert file path (file that will be triggered when honeypot is accessed)
$alertFilePath = Read-Host "Please enter the path for the alert file to trigger (e.g., C:\path\to\honeypot_alert.txt)"

# Ensure the alert file path is valid
if (-not (Test-Path -Path (Split-Path $alertFilePath))) {
    Write-Host "The alert file directory does not exist. Please ensure the directory exists before proceeding."
    exit
}

# Variables for honeypot configuration
$honeypotFileContent = @"
user1: password123
admin: qwerty456
guest: letmein789
"@

# 1. Create the Honeypot File
Write-Host "Creating honeypot file at $honeypotFilePath"
Set-Content -Path $honeypotFilePath -Value $honeypotFileContent
Write-Host "Honeypot file created successfully."

# 2. Enable Object Access Auditing (Group Policy)
Write-Host "Enabling Object Access Auditing..."
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
if (-not (Test-Path $regKey)) {
    New-Item -Path $regKey -Force
}

# Enabling Object Access auditing (requires admin privileges)
Set-ItemProperty -Path $regKey -Name "AuditObjectAccess" -Value 1
Write-Host "Object Access Auditing enabled."

# 3. Configure the File Auditing (set auditing on the honeypot file)
Write-Host "Configuring auditing for file: $honeypotFilePath"
$acl = Get-Acl $honeypotFilePath
$auditingRule = New-Object System.Security.AccessControl.FileSystemAuditRule(
    "Everyone", 
    "ReadData, WriteData", 
    "Allow", 
    "Success, Failure"
)
$acl.AddAuditRule($auditingRule)
Set-Acl -Path $honeypotFilePath -AclObject $acl
Write-Host "File auditing configured successfully."

# 4. Create Task Scheduler Trigger for Event ID 4663 (Honeypot file access)
Write-Host "Creating Task Scheduler task to trigger on Event ID 4663 (Honeypot file access)..."

# The task action should be to open the specific alert file with the default program
$taskAction = New-ScheduledTaskAction -Execute $alertFilePath  # Open the alert text file directly

# Set trigger to fire when Event ID 4663 is logged for the honeypot file
$taskTrigger = New-ScheduledTaskTrigger -AtStartup
$taskTrigger.EventTrigger = @{
    LogName  = 'Security'
    EventID  = 4663
    XPathQuery = "*[EventData[Data[@Name='ObjectType'] and (Data='File')]] and *[EventData[Data[@Name='ObjectName'] and (Data='$honeypotFilePath')]]"
}

# Define the task settings (ensure it runs with highest privileges)
$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteriesConnected $true -DontStopIfGoingOnBatteries $true -StartWhenAvailable $true -RunOnlyIfIdle $false

# Create the scheduled task
Register-ScheduledTask -Action $taskAction -Trigger $taskTrigger -TaskName "HoneypotFileAccessAlert" -Description "Task to trigger when honeypot file is accessed" -Settings $taskSettings -User "SYSTEM"

Write-Host "Task Scheduler task created successfully to trigger on Event ID 4663 for honeypot file access."

# 5. (Optional) Run a test to confirm everything is working
Write-Host "Testing honeypot file access..."
Invoke-Item $honeypotFilePath  # Simulate an access to the honeypot file
Write-Host "Honeypot file access simulated."

Write-Host "Honeypot setup complete! The script has finished running."
