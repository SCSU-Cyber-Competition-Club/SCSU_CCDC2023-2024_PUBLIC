#!/bin/env bash

# Set Palo Alto management IP address.
#echo "Please enter Palo Alto IP address."
#read PALO_ALTO_IP
PALO_ALTO_IP='10.0.0.3'

# Set Palo Alto management username.
#echo "Please enter Palo Alto username."
#read PALO_ALTO_USER
PALO_ALTO_USER='dust'

# Set Palo Alto management password.
#echo "Please enter Palo Alto password."
#read PALO_ALTO_PASS
PALO_ALTO_PASS='P@ssw0rd'

# Curl command to get API_KEY
API_KEY=$(curl -s -k -X POST "https://$PALO_ALTO_IP/api/?type=keygen&user=$PALO_ALTO_USER&password=$PALO_ALTO_PASS" | grep -oP '(?<=<key>)(.*?)(?=</key>)')

# Get Address Objects
curl -o address.txt -s -k -X GET \
					"https://$PALO_ALTO_IP/restapi/v11.0/Objects/Addresses?location=vsys&vsys=vsys1" \
					-H "X-PAN-KEY: $API_KEY"

# Get Service Objects
curl -o service.txt -s -k -X GET \
					"https://$PALO_ALTO_IP/restapi/v11.0/Objects/Services?location=vsys&vsys=vsys1" \
					-H "X-PAN-KEY: $API_KEY"

# Get Application Objects
curl -o application.txt -s -k -X GET \
					"https://$PALO_ALTO_IP/restapi/v11.0/Objects/Applications?location=vsys&vsys=vsys1" \
					-H "X-PAN-KEY: $API_KEY"

					# Get Policy Objects
curl -o policy.txt -s -k -X GET \
					"https://$PALO_ALTO_IP/restapi/v11.0/Policies/SecurityRules?location=vsys&vsys=vsys1" \
					-H "X-PAN-KEY: $API_KEY"