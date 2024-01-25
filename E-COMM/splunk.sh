#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root."
  exit 1
fi

# Splunk Forwarder Details
SPLUNK_FORWARDER_VERSION="8.3.3"  # Replace with the version you are using
SPLUNK_FORWARDER_BUILD="f44afce3db66"  # Replace with the build number

# Splunk Server Details
SPLUNK_SERVER="172.20.241.20"
SPLUNK_SERVER_PORT="9997"

# Install Splunk Forwarder
sudo rpm -i splunkforwarder-"$SPLUNK_FORWARDER_VERSION"-"$SPLUNK_FORWARDER_BUILD".rpm

# Start Splunk Forwarder
/opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt

# Configure Splunk Forwarder
cat <<EOF >> /opt/splunkforwarder/etc/system/local/inputs.conf
[monitor:///var/log/httpd/access_log]
disabled = false
index = your_index

[monitor:///var/log/httpd/error_log]
disabled = false
index = your_index
EOF

cat <<EOF >> /opt/splunkforwarder/etc/system/local/outputs.conf
[tcpout]
defaultGroup = your_indexers

[tcpout:your_indexers]
server = $SPLUNK_SERVER:$SPLUNK_SERVER_PORT
EOF

# Restart Splunk Forwarder
/opt/splunkforwarder/bin/splunk restart

echo "Splunk Forwarder setup complete."
