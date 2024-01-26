#!/bin/bash

# Log file for installation
log_file="/var/log/splunk_install.log"
exec > >(sudo tee -a "$log_file") 2>&1
echo "Log started: $(date)"

# Check for dependencies
if ! sudo command -v wget &> /dev/null; then
    echo "wget is not installed. Please install it before running the script."
    exit 1
else
    mkdir -p /opt/splunkforwarder
fi

Check if Splunk is already installed
SPLUNK_HOME="/opt/splunkforwarder"
SPLUNK_BIN="/opt/splunkforwarder/splunkforwarder/bin"
if [ -d "$SPLUNK_BIN" ]; then
   echo "Splunk is already installed. Exiting."
   exit 1
else
   mkdir -p /opt/splunkforwarder
fi

mkdir -p $SPLUNK_HOME

# Navigate to Splunk installation directory
cd "$SPLUNK_HOME"

# Set Splunk download URL
SPLUNKURL="https://download.splunk.com/products/universalforwarder/releases/8.2.2/linux/splunkforwarder-8.2.2-87344edfcdb4-Linux-x86_64.tgz"

# Download and extract Splunk
sudo wget -O "$SPLUNK_HOME/splunkforwarder.tgz" "$SPLUNKURL"
sudo tar -xzf "$SPLUNK_HOME/splunkforwarder.tgz"
sudo rm "$SPLUNK_HOME/splunkforwarder.tgz"

# Set ownership and permissions
sudo chmod 770 $SPLUNK_HOME

# Start Splunk and enable boot-start
cd "$SPLUNK_HOME/splunkforwarder/bin"
sudo ./splunk start --accept-license
sudo ./splunk enable boot-start -user root

# Set Splunk server IP
FORWARDSERVER="172.20.241.20:9997"

# Add forward server
sudo ./splunk add forward-server "$FORWARDSERVER"

# Add monitoring for /var/log
sudo ./splunk add monitor /var/log

# Restart Splunk
sudo ./splunk restart

echo "Splunk installation completed successfully."
exit 0
