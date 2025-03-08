#!/bin/env bash

# Set Cisco management IP address.
echo "Please enter FDM IP address."
read FDM_IP
#FDM_IP="10.0.0.4"

# Set Cisco management username.
echo "Please enter Cisco username."
read USERNAME
#USERNAME="admin"

# Set Cisco management password.
echo "Please enter Cisco password."
read PASSWORD
#PASSWORD="P@ssw0rd"

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

# Networks
DMZ_ZONE="172.20.240.0/24"
ServerLAN_ZONE="172.20.240.0/24"
WKSTLAN_ZONE="172.20.240.0/24"

# Zones

# Set Outside Zone.
echo "Please enter outside_zone name"
read outside_zone
#outside_zone="outside_zone"

# Set Inside Zone.
echo "Please enter inside_zone name"
read inside_zone
#inside_zone="inside_zone"

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

curl -s -k -X GET "${URL2}object/networks" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}" | \
grep -A 5 '"name" : "email1"' | sed 's/^[ \t]*//'


# Setting  Hosts Addresses
# Setting  Hosts Addresses
# Setting  Hosts Addresses


# Create network object email
echo "Creating network object 'email'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"email\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${email_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
email_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo
  
# Create network object DNS_NTP
echo "Creating network object 'DNS_NTP'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"DNS_NTP\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${DNS_NTP_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
DNS_NTP_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object SnipeIT
echo "Creating network object 'SnipeIT'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"SnipeIT\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${SnipeIT_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
SnipeIT_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object SecurityOnion
echo "Creating network object 'SecurityOnion'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"SecurityOnion\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${SecurityOnion_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
SecurityOnion_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object AD_DNS_DHCP
echo "Creating network object 'AD_DNS_DHCP'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"AD_DNS_DHCP\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${AD_DNS_DHCP_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
AD_DNS_DHCP_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object CiscoFTD
echo "Creating network object 'CiscoFTD'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"CiscoFTD\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${CiscoFTD_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
CiscoFTD_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object ubuntu
echo "Creating network object 'ubuntu'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"ubuntu\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${ubuntu_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
ubuntu_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object windows10
echo "Creating network object 'windows10'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"windows10\",
    \"description\": \"\",
    \"subType\": \"HOST\",
    \"value\": \"${windows10_IP}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
windows10_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo



# Setting  Network Addresses
# Setting  Network Addresses
# Setting  Network Addresses


# Create network object DMZ_ZONE
echo "Creating network object 'DMZ_ZONE'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"DMZ_ZONE\",
    \"description\": \"\",
    \"subType\": \"NETWORK\",
    \"value\": \"${DMZ_ZONE}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
DMZ_ZONE_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object ServerLAN_ZONE
echo "Creating network object 'ServerLAN_ZONE'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"ServerLAN_ZONE\",
    \"description\": \"\",
    \"subType\": \"NETWORK\",
    \"value\": \"${ServerLAN_ZONE}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
ServerLAN_ZONE_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create network object WKSTLAN_ZONE
echo "Creating network object 'WKSTLAN_ZONE'..."
POST_RESPONSE=$(curl -s -k -X POST \
  "${URL2}object/networks" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "{
    \"name\": \"WKSTLAN_ZONE\",
    \"description\": \"\",
    \"subType\": \"NETWORK\",
    \"value\": \"${WKSTLAN_ZONE}\",
    \"isSystemDefined\": false,
    \"dnsResolution\": \"IPV4_AND_IPV6\",
    \"type\": \"networkobject\"
  }")
WKSTLAN_ZONE_ID=$(echo "$POST_RESPONSE" | grep -o '"id" *: *"[^"]*"' | sed 's/.*: *"\([^"]*\)"/\1/')
RESPONSE_CHECK
echo

# Create Access Policy Rules
# Create Access Policy Rules
# Create Access Policy Rules

# Get Access Policy ID
ACCESSPOLICYID=$(curl -s -k -X GET "${URL2}/policy/accesspolicies" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}" | \
     grep '"id" : ' | sed 's/.*"id" : "\(.*\)",/\1/')

# Print the Access Policy ID
echo "Access Policy ID: $ACCESSPOLICYID"
echo


# Get Zone ID - Outside
ZONEID=$(curl -s -k -X GET "${URL2}/object/securityzones" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}")

OUTSIDE_ZONE_ID=$(echo "$ZONEID" | grep -A 6 '"name" : "outside_zone"' | grep '"id" :' | sed 's/.*"id" : "\([^"]*\)".*/\1/')


# Get Zone ID - Inside
ZONEID=$(curl -s -k -X GET "${URL2}/object/securityzones" \
     -H "Content-Type: application/json" \
     -H "Authorization: Bearer ${API_KEY}")

INSIDE_ZONE_ID=$(echo "$ZONEID" | grep -A 6 '"name" : "inside_zone"' | grep '"id" :' | sed 's/.*"id" : "\([^"]*\)".*/\1/')