#!/bin/env bash

# Set Cisco management IP address.
#echo "Please enter FDM IP address."
#read FDM_IP
FDM_IP="10.0.0.4"

# Set Cisco management username.
#echo "Please enter Cisco username."
#read USERNAME
USERNAME="admin"

# Set Cisco management password.
#echo "Please enter Cisco password."
#read PASSWORD
PASSWORD="P@ssw0rd"

# Setting Cisco FDM URLs.
URL="https://${FDM_IP}/api/fdm/latest/fdm/token"
URL2="https://${FDM_IP}/api/fdm/latest/"

# Network Object IPs
#DMZ
email_IP="172.20.240.11"
DNS_NTP_IP="172.20.240.23"
web_IP="172.20.240.5"
SnipeIT_IP="172.20.240.97"
#ServerLAN
SecurityOnion_IP="172.20.241.3"
AD_DNS_DHCP_IP="172.20.241.27"
CiscoFTD_IP="172.20.241.100"
#WorkstationLAN
ubuntu_IP="172.20.242.5"
windows10_IP="172.20.242.6"

# Network Zones
DMZ_ZONE="172.20.240.0/24"
ServerLAN_ZONE="172.20.240.0/24"
WKSTLAN_ZONE="172.20.240.0/24"


# Function to check POST response
RESPONSE_CHECK() {
  if echo "$POST_RESPONSE" | grep -q '"id"'; then
    echo "Network object created successfully."
  elif echo "$POST_RESPONSE" | grep -q '"duplicateName"'; then
    echo "Network object already exists."
  else
    echo "Failed to create network object for an unknown reason."
    echo "Response: $POST_RESPONSE"
  fi
}

# Use variables in the curl command
API_KEY=$(curl -s -k -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' \
-d "{
   \"grant_type\": \"password\", 
   \"username\": \"${USERNAME}\", 
   \"password\": \"${PASSWORD}\"
 }" "${URL}" | \
  grep -o '"access_token":"[^"]*' | \
  sed 's/"access_token":"//')

# Print the API_KEY
echo "API Key: $API_KEY"
echo

# Get Access Policy ID
ACCESSPOLICYID=$(curl -s -k -X GET "${URL2}/policy/accesspolicies" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}" | \
     grep '"id" : ' | sed 's/.*"id" : "\(.*\)",/\1/')

# Print the Access Policy ID
echo "Access Policy ID: $ACCESSPOLICYID"
echo

# Get Access Policy Rules
ACCESSPOLICYID=$(curl -s -k -X GET "${URL2}/policy/accesspolicies/${ACCESSPOLICYID}/accessrules" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}")
     
# Print the Access Policy Rules
echo "Access Policy Rules:"
echo "$ACCESSPOLICYID"
echo

# Get Zone ID - Outside
ACCESSPOLICYID=$(curl -s -k -X GET "${URL2}/object/securityzones" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}")

# Print Security Zones
echo "Security Zones:"
echo "$ACCESSPOLICYID"
echo