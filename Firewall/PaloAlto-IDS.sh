#!/bin/env bash

# Set Palo Alto management IP address.
echo "Please enter Palo Alto IP address."
read PALO_ALTO_IP
#PALO_ALTO_IP='172.20.242.150'

# Set Palo Alto management username.
echo "Please enter Palo Alto username."
read PALO_ALTO_USER
#PALO_ALTO_USER='superuser'

# Set Palo Alto management password.
echo "Please enter Palo Alto password."
read PALO_ALTO_PASS
#PALO_ALTO_PASS='P@ssw0rd'

# Set Palo Alto version.
echo "Please enter Palo Alto Version."
read PALO_ALTO_VERSION
#PALO_ALTO_VERSION='11.0'

# Setting Palo Alto URLs.
URL="https://${PALO_ALTO_IP}/restapi/v${PALO_ALTO_VERSION}"


# Network Objects
# 1 added to end of names to ensure values are unique.

# Networks
public_net1="172.20.241.0\/24" # Public Network
user_net1="172.20.242.0\/24" # User Network
internal_net1="172.20.240.0\/24" # Internal Network

# Interfaces
public_int1="172.20.241.254\/24" # Public Interface
user_int1="172.20.242.254\/24" # User Interface
internal_int1="172.20.240.254\/24" # Internal Interface

# INTERNAL Network
win19_docker1="172.20.240.10\/24" # 2019 Docker Remote
debian1="172.20.240.20\/24" #Debian 10 DNS NTP

# USER Network
ubuntu_web1="172.20.242.10\/24" # Ubuntu 18 Web
win19_ad1="172.20.242.200\/24" # 2019 AD DNS DHCP
ubuntu_wkst1="172.20.242.20\/24" # Ubuntu Workstation
palo_alto1="172.20.242.150\/24" # Palo Alo Management

# PUBLIC Network
splunk1="172.20.241.20\/24" # Splunk 9.1.1
centos_ecomm1="172.20.241.30\/24" # CentOS 7 E-comm
fedora_webmail1="172.20.241.40\/24" # Fedora 21 Webmail WebApps


# Curl command to get API_KEY
API_KEY=$(curl -s -k -X POST "https://$PALO_ALTO_IP/api/?type=keygen&user=$PALO_ALTO_USER&password=$PALO_ALTO_PASS" | grep -oP '(?<=<key>)(.*?)(?=</key>)')

# Function to check POST response
ADD_ADDRESS_OBJECT() {
    # Make the curl request and capture the response
    response=$(curl -k -s -X POST \
        "${URL}/Objects/Addresses?location=vsys&vsys=vsys1&name=${current_name}" \
        -H "X-PAN-KEY: $API_KEY" \
        -d "{
            \"entry\": [
                {
                    \"@location\": \"vsys\",
                    \"@name\": \"${current_name}\",
                    \"@vsys\": \"vsys1\",
                    \"description\": \"${current_desc}\",
                    \"ip-netmask\": \"${current_ip}\"
                }
            ]
        }")
    # Check the response for "Object Not Unique" and echo accordingly
    if echo "$response" | grep -q "Object Not Unique"; then
        echo "${current_name} Address Object already exists."
    else
        echo "${current_name} Address Object created."
    fi
}

SERVICE_OBJECT_RESPONSE() {
    # Check the response for "Object Not Unique" and echo accordingly
    if echo "$response" | grep -q "Object Not Unique"; then
        echo "${current_name} Service Object already exists."
    else
        echo "${current_name} Service Object created."
    fi
}

SECURITY_RULE_RESPONSE() {
    # Check the response for "Object Not Unique" and echo accordingly
    if echo "$response" | grep -q "Object Not Unique"; then
        echo "${current_name} Security Rule already exists."
    else
        echo "${current_name} Security Rule created."
    fi
}

DOS_PROFILE_RESPONSE() {
    # Check the response for "Object Not Unique" and echo accordingly
    if echo "$response" | grep -q "Object Not Unique"; then
        echo "${current_name} Protection Security Profile already exists."
    else
        echo "${current_name} Protection Security Profile created."
    fi
}

# Begin Address object section
# Begin Address object section
# Begin Address object section

echo
echo
echo "Start of Address Objects"

# Add address object - public_int1
current_name="public_net1"
current_ip="${public_net1}"
current_desc="Public Interface"
ADD_ADDRESS_OBJECT

# Add address object - user_int1
current_name="user_net1"
current_ip="${user_net1}"
current_desc="User Interface"
ADD_ADDRESS_OBJECT

# Add address object - internal_int1
current_name="internal_int1"
current_ip="${internal_int1}"
current_desc="Internal Interface"
ADD_ADDRESS_OBJECT

# Add address object - public_net1
current_name="public_net1"
current_ip="${public_net1}"
current_desc="Public Network"
ADD_ADDRESS_OBJECT

# Add address object - user_net1
current_name="user_net1"
current_ip="${user_net1}"
current_desc="User Network"
ADD_ADDRESS_OBJECT

# Add address object - internal_net1
current_name="internal_net1"
current_ip="${internal_net1}"
current_desc="Internal Network"
ADD_ADDRESS_OBJECT

# Add address object - win19_docker1
current_name="win19_docker1"
current_ip="${win19_docker1}"
current_desc="2019 Docker Remote"
ADD_ADDRESS_OBJECT

# Add address object - debian1
current_name="debian1"
current_ip="${debian1}"
current_desc="Debian 10 DNS NTP"
ADD_ADDRESS_OBJECT

# Add address object - ubuntu_web1
current_name="ubuntu_web1"
current_ip="${ubuntu_web1}"
current_desc="Ubuntu 18 Web"
ADD_ADDRESS_OBJECT

# Add address object - win19_ad1
current_name="win19_ad1"
current_ip="${win19_ad1}"
current_desc="2019 AD DNS DHCP"
ADD_ADDRESS_OBJECT

# Add address object - ubuntu_wkst1
current_name="ubuntu_wkst1"
current_ip="${ubuntu_wkst1}"
current_desc="Ubuntu_Workstation"
ADD_ADDRESS_OBJECT

# Add address object - palo_alto1
current_name="palo_alto1"
current_ip="${palo_alto1}"
current_desc="Palo Alo Management"
ADD_ADDRESS_OBJECT

# Add address object - splunk1
current_name="splunk1"
current_ip="${splunk1}"
current_desc="Splunk 9.1.1"
ADD_ADDRESS_OBJECT

# Add address object - centos_ecomm1
current_name="centos_ecomm1"
current_ip="${centos_ecomm1}"
current_desc="CentOS 7 E-comm"
ADD_ADDRESS_OBJECT


# Add address object - fedora_webmail1
current_name="fedora_webmail1"
current_ip="${fedora_webmail1}"
current_desc="Fedora 21 Webmail WebApps"
ADD_ADDRESS_OBJECT


# Begin Service object section
# Begin Service object section
# Begin Service object section


echo
echo "Start of Service Objects"

# Add service object - splunk_fwd
current_name="splunk_fwd"
resonse=$(curl -k -s -X POST \
					"${URL}/Objects/Services?location=vsys&vsys=vsys1&name=splunk_fwd" \
					-H "X-PAN-KEY: $API_KEY" \
					-d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "splunk_fwd",
            "@vsys":"vsys1",
            "protocol": {
            	"tcp": {
            	"port": "9000,9997"
            	}
            }
        }
    ]
}'
)
SERVICE_OBJECT_RESPONSE


# Begin Security rules section
# Begin Security rules section
# Begin Security rules section


# Source Zone - from
# Source Address - source
# Destination Zone - to
# Destination Address - destination
# Application - application
# Service - service
# action - action

echo
echo "Start of Securtiy Rules"
echo

# to-External Section
echo "To-external Section"

# Add security Rule docker-to-external
current_name="docker-to-external"
resonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=docker-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "docker-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "2019_docker1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule debian-to-external
current_name="debian-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=debian-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "debian-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "debian1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule ubuntuweb-to-external
current_name="ubuntuweb-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=ubuntuweb-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ubuntuweb-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "ubuntu_web1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule 2019_ad-to-external
current_name="2019_ad-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=2019_ad-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "2019_ad-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "2019_ad1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule ubuntuwkst-to-external
current_name="ubuntuwkst-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=ubuntuwkst-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ubuntuwkst-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "ubuntu_wkst1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule splunk-to-external
current_name="splunk-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=splunk-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "splunk-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "splunk",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Public"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "splunk1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule ecomm-to-external
current_name="ecomm-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=ecomm-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "ecomm-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Public"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "centos_ecomm1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule webmail-to-external
current_name="webmail-to-external"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=webmail-to-external" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "webmail-to-external",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "web-browsing",
                    "ssl",
                    "ntp-base",
                    "dns-base",
                    "ping",
                    "icmp",
                    "pop3",
                    "imap",
                    "smtp-base"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Public"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "fedora_webmail1"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "External"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

echo
# External-to Section
echo "External-to Section"

# Add security Rule external-to-docker
current_name="external-to-docker"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-docker" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-docker",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "2019_docker1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE


# Add security Rule external-to-debian
current_name="external-to-debian"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-debian" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-debian",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "ntp-base",
                    "dns-base"                    
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "debian1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule external-to-ubuntuweb
current_name="external-to-ubuntuweb"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-ubuntuweb" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-ubuntuweb",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "web-browsing",
                    "ssl"                    
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "ubuntu_web1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "User"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule external-to-2019_ad
current_name="external-to-2019_ad"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-2019_ad" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-2019_ad",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base"               
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "2019_ad1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "User"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule external-to-ubuntuwkst
current_name="external-to-ubuntuwkst"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-ubuntuwkst" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-ubuntuwkst",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp"            
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "ubuntu_wkst1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "User"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule external-to-splunk
current_name="external-to-splunk"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-splunk" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-splunk",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "splunk"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "splunk1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Public"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule external-to-ecomm
current_name="external-to-ecomm"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-ecomm" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-ecomm",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "web-browsing",
                    "ssl"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "centos_ecomm1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Public"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# Add security Rule external-to-webmail
current_name="external-to-webmail"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=external-to-webmail" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "external-to-webmail",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "web-browsing",
                    "ssl",
                    "pop3",
                    "imap",
                    "smtp-base"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "fedora_webmail1"
                ]
            },
            "from": {
                "member": [
                    "External"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Public"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE


echo
# Interzone Section
echo "Interzone Section"

# Add security Rule interzone
current_name="interzone"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=interzone" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "interzone",
            "@vsys": "vsys1",
            "action": "allow",
            "rule-type": "interzone",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "ldap",
                    "web-browsing",
                    "ssl",
                    "splunk"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

echo
# Intrazone Section
echo "Intrazone Section"

# Add security Rule intrazone
current_name="intrazone"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=intrazone" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "intrazone",
            "@vsys": "vsys1",
            "action": "allow",
            "rule-type": "intrazone",
            "application": {
                "member": [
                    "ping",
                    "icmp",
                    "dns-base",
                    "ldap",
                    "web-browsing",
                    "ssl",
                    "splunk"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "application-default"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

# to-External Section
echo "Inside Services Section"

# Add security Rule inside_services
current_name="inside_services"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=inside_services" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "inside_services",
            "@vsys": "vsys1",
            "action": "allow",
            "application": {
                "member": [
                    "any"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "splunk_fwd",
                    "service-http",
                    "service-https"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE

echo
# Drop-any Section
echo "Drop-any Section"

# Add security Rule drop-any
current_name="drop-any"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/SecurityRules?location=vsys&vsys=vsys1&name=drop-any" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@location": "vsys",
            "@name": "drop-any",
            "@vsys": "vsys1",
            "action": "drop",
            "application": {
                "member": [
                    "any"
                ]
            },
            "category": {
                "member": [
                    "any"
                ]
            },
            "destination": {
                "member": [
                    "any"
                ]
            },
            "from": {
                "member": [
                    "any"
                ]
            },
            "source-hip": {
            	"member": [
            		"any"
            	]
            },
            "destination-hip": {
            	"member": [
            		"any"
	            ]
            },
            "service": {
                "member": [
                    "any"
                ]
            },
            "source": {
                "member": [
                    "any"
                ]
            },
            "source-user": {
                "member": [
                    "any"
                ]
            },
            "to": {
                "member": [
                    "any"
                ]
            },
              "profile-setting": {
                "profiles": {
                "url-filtering": {
                    "member": [
                    "default"
                    ]
                },
                "virus": {
                    "member": [
                    "default"
                    ]
                },
                "spyware": {
                    "member": [
                    "default"
                    ]
                },
                "vulnerability": {
                    "member": [
                    "default"
                    ]
                },
                "wildfire-analysis": {
                    "member": [
                    "default"
                    ]
                }    
                }
            }
        }
    ]
}'
)
SECURITY_RULE_RESPONSE


echo
# DoS Protection Security Profiles
echo "DoS Protection Security Profiles Section"

# Add DoS Protection Security Profile
current_name="BlockExcessiveConnections"
respsonse=$(curl -k -s -X POST \
  "${URL}/Objects/DoSProtectionSecurityProfiles?location=vsys&vsys=vsys1&name=BlockExcessiveConnections" \
  -H "X-PAN-KEY: $API_KEY" \
  -d '{
    "entry": [
        {
            "@name": "BlockExcessiveConnections",
            "@location": "vsys",
            "@vsys": "vsys1",
            "flood": {
                "tcp-syn": {
                "red": {
                    "alarm-rate": "50",
                    "activate-rate": "50",
                    "maximal-rate": "100"
                },
                "enable": "yes"
                },
                "udp": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                },
                "icmp": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                },
                "icmpv6": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                },
                "other-ip": {
                "red": {
                    "maximal-rate": "100",
                    "alarm-rate": "50",
                    "activate-rate": "50"
                },
                "enable": "yes"
                }
            },
            "resource": {
                "sessions": {
                "enabled": "no"
                }
            },
            "type": "classified"
        }
    ]
}'
)
DOS_PROFILE_RESPONSE

echo
# DoS Protection Policy
echo "DoS Protection Policy Section"

# Add DoS Protection Policy
current_name="DoS"
respsonse=$(curl -k -s -X POST \
  "${URL}/Policies/DoSRules?location=vsys&vsys=vsys1&name=DoS" \
  -H "X-PAN-KEY: $API_KEY" \
-d '{
    "entry": [
        {
            "@name": "DoS",
            "@location": "vsys",
            "@vsys": "vsys1",
            "from": {
                "zone": {
                "member": [
                    "External"
                ]
                }
            },
            "to": {
                "zone": {
                "member": [
                    "Internal",
                    "Public",
                    "User"
                ]
                }
            },
            "protection": {
                "classified": {
                "classification-criteria": {
                    "address": "source-ip-only"
                },
                "profile": "BlockExcessiveConnections"
                }
            },
            "source": {
                "member": [
                "any"
                ]
            },
            "destination": {
                "member": [
                "any"
                ]
            },
            "source-user": {
                "member": [
                "any"
                ]
            },
            "service": {
                "member": [
                "any"
                ]
            },
            "action": {
                "deny": {}
            }
        }
    ]
}'
)
DOS_PROFILE_RESPONSE