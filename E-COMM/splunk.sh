#!/bin/bash

# Log file for installation
log_file="/var/log/splunk_install.log"
exec > >(sudo tee -a "$log_file") 2>&1
echo "Log started: $(date)"

# Check for dependencies
if ! sudo command -v wget &> /dev/null; then
    echo "wget is not installed. Please install it before running the script."
    exit 1
fi

# Check if Splunk is already installed
SPLUNK_HOME="/opt/splunkforwarder"
if [ -d "$SPLUNK_HOME" ]; then
    echo "Splunk is already installed. Exiting."
    exit 1
fi


# Navigate to Splunk installation directory
cd "$SPLUNK_HOME"

# Set Splunk download URL
SPLUNKURL="https://download.splunk.com/products/universalforwarder/releases/8.2.2/linux/splunkforwarder-8.2.2-87344edfcdb4-Linux-x86_64.tgz"

# Download and extract Splunk
sudo wget -O "$SPLUNK_HOME/splunkforwarder.tgz" "$SPLUNKURL"
sudo tar -xzf "$SPLUNK_HOME/splunkforwarder.tgz"
sudo rm "$SPLUNK_HOME/splunkforwarder.tgz"

# Set ownership and permissions
sudo chown --recursive splunk:splunk "$SPLUNK_HOME"

# Start Splunk and enable boot-start
cd "$SPLUNK_HOME/bin"
sudo chmod 770 splunk
sudo ./splunk start --accept-license
sudo ./splunk enable boot-start -user splunk

# Set Splunk server IP
FORWARDSERVER="172.20.241.20:9997"

# Add forward server
sudo ./splunk add forward-server "$FORWARDSERVER"

# Add monitoring for /var/log
sudo ./splunk add monitor /var/log

# Restart Splunk
sudo ./splunk restart

echo "Splunk installation completed successfully."
