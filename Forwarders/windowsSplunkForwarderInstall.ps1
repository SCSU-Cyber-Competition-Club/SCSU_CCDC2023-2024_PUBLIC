param (
    # Optional: Specify the IP address of the Splunk Indexer (receiver).
    [string]$INDEXER_IP = "172.20.242.20",

    # Optional: Specify the hostname to be used by Splunk.
    # Defaults to the machine's current hostname.
    [string]$SplunkHostname = $env:COMPUTERNAME
)

# PowerShell script to install and configure Splunk Universal Forwarder on Windows machines
# This was originally written in Bash, then translated to Powershell. An AI was (obviously) used heavily in this process. I only know a small, salty lick of
# PowerShell, this is 70% AI, 25% forums, and 5% me pushing buttons until it worked.
#
# You can be mean to this one. I know it's rough.
#
# Currently set to v10.0.1. I'm not sure if the link will be valid during the entire CCDC season
# with how much is still left to go. If the download gives you any trouble, create a Splunk account, go to the universal forwarder downloads, pick the one you want,
# then extract the random set of characters found in the link. In this script, these are stored in the variable "SPLUNK_BUILD".
#
#
# # Please note that no monitors, besides a sample test one, are included. My team is using some custom tooling we'd like to keep private for now, and I want to encourage
# people to learn at least a little bit of Splunk to make use of this script. My only request for using this script is that if you ever make any improvements, please share
# them with the community. This will not be enforced with a license.
#
#
# Samuel Brucker 2024 - 2026

# SCSU club members, you better give that guy a big ol' thanks if you ever meet them at a competition!

# Define variables
$SPLUNK_VERSION = "10.0.1"
$SPLUNK_BUILD = "c486717c322b"
$SPLUNK_MSI = "splunkforwarder-${SPLUNK_VERSION}-${SPLUNK_BUILD}-windows-x64.msi"
$SPLUNK_DOWNLOAD_URL = "https://download.splunk.com/products/universalforwarder/releases/${SPLUNK_VERSION}/windows/${SPLUNK_MSI}"
$INSTALL_DIR = "C:\Program Files\SplunkUniversalForwarder"
# $INDEXER_IP is now defined in the param() block at the top
$RECEIVER_PORT = "9997"

# Download Splunk Universal Forwarder MSI
Write-Host "Downloading Splunk Universal Forwarder MSI..."
#take away the progress bar, but drastically speeds up downloads on older powershell versions. On server 2019, I'm not joking that it's at least 20x or 30x faster
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $SPLUNK_DOWNLOAD_URL -OutFile $SPLUNK_MSI

# Install Splunk Universal Forwarder
Write-Host "Installing Splunk Universal Forwarder..."
# The $INDEXER_IP variable will be pulled from the parameters
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i $SPLUNK_MSI AGREETOLICENSE=Yes RECEIVING_INDEXER=${INDEXER_IP}:${RECEIVER_PORT} /quiet" -Wait

# Configure inputs.conf for monitoring
$inputsConfPath = "$INSTALL_DIR\etc\system\local\inputs.conf"
Write-Host "Configuring inputs.conf for monitoring..."

@"
[WinEventLog://Microsoft-Windows-Sysmon/Operational]
disabled = 0
index = sysmon
renderXml = true

[WinEventLog://Security]
disabled = 0
index = security
renderXml = false
"@ | Out-File -FilePath $inputsConfPath -Encoding ASCII -Append

# Configure server.conf to use the specified hostname
$serverConfPath = "$INSTALL_DIR\etc\system\local\server.conf"
Write-Host "Setting custom hostname for the logs to '$SplunkHostname'..."
# The $SplunkHostname variable will be pulled from the parameters
@"
[general]
serverName = $SplunkHostname
hostnameOption = shortname
"@ | Out-File -FilePath $serverConfPath -Encoding ASCII

# Start Splunk Universal Forwarder service
Write-Host "Starting Splunk Universal Forwarder service..."
Start-Process -FilePath "$INSTALL_DIR\bin\splunk.exe" -ArgumentList "start" -Wait

# Set Splunk Universal Forwarder to start on boot
Write-Host "Setting Splunk Universal Forwarder to start on boot..."
Start-Process -FilePath "$INSTALL_DIR\bin\splunk.exe" -ArgumentList "enable boot-start" -Wait

Write-Host "Splunk Universal Forwarder installation and configuration complete!"
