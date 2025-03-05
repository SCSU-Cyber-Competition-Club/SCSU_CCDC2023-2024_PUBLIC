# Define Variables
$sysmonUrl = "https://download.sysinternals.com/files/Sysmon.zip"
$sysmonZip = "$env:TEMP\Sysmon.zip"
$sysmonExtractPath = "$env:TEMP\Sysmon"
$sysmonConfigUrl = "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml"
$sysmonConfigPath = "$env:TEMP\sysmonconfig.xml"
$sysmonExe = "$sysmonExtractPath\Sysmon64.exe"

# Function to Download Files
Function Download-File {
    param([string]$url, [string]$destination)
    Invoke-WebRequest -Uri $url -OutFile $destination
}

# Step 1: Download Sysmon
Write-Output "Downloading Sysmon..." -ForeGroundColor Red
Download-File -url $sysmonUrl -destination $sysmonZip

# Step 2: Extract Sysmon
Write-Output "Extracting Sysmon..."
Expand-Archive -Path $sysmonZip -DestinationPath $sysmonExtractPath -Force

# Step 3: Download Sysmon Config (SwiftOnSecurity)
Write-Output "Downloading Sysmon Configuration..."
Download-File -url $sysmonConfigUrl -destination $sysmonConfigPath

# Step 4: Install Sysmon with Config
Write-Output "Installing and Configuring Sysmon..."
Start-Process -FilePath $sysmonExe -ArgumentList "-accepteula -i $sysmonConfigPath" -NoNewWindow -Wait

# Step 5: Verify Sysmon is Running
Write-Output "Checking Sysmon Service Status..."
if (Get-Service -Name Sysmon64 -ErrorAction SilentlyContinue) {
    Write-Output "Sysmon is installed and running."
} else {
    Write-Output "Sysmon installation failed."
}

# Cleanup
Write-Output "Cleaning up temporary files..."
Remove-Item -Path $sysmonZip -Force
Remove-Item -Path $sysmonExtractPath -Recurse -Force
Remove-Item -Path $sysmonConfigPath -Force

Write-Output "Sysmon Setup Completed Successfully!" -ForeGroundColor Red