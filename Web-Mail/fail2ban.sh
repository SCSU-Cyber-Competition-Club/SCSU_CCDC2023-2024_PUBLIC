#!/bin/bash
# fail2ban.sh

# Check for root
if [[ "$(id -u)" != "0" ]]
then
    printf "${error}ERROR: The script must be run with sudo privileges!${reset}\n"
    exit 1
fi

# get some version information
. /etc/os-release


if [[ "$ID" == "centos" && $VERSION_ID -gt 6 ]] || \
   [[ "$ID" == "fedora" && $VERSION_ID -gt 21 ]] || \
   [[ "$ID" == "rhel" && $VERSION_ID -gt 6 ]]
then
    # try to use fail2ban and install if needed.
    which fail2ban >/dev/null
    if [[ $? -ne 0 ]]
    then
        yum install fail2ban -y
		printf "Installed fail2ban"
	fi
	
	# Configure fail2ban
	systemctl enable fail2ban
	systemctl start fail2ban
	printf "fail2ban Enabled/Started"
else
    printf "${error}ERROR: Fail2ban did not install or start.${reset}\n"
    exit 1
fi	
	
cat > /etc/fail2ban/jail.local <<- EOM
	backend = systemd
	[sshd]
	enabled = true
	bantime = 5m
	maxretry = 3
	EOM
printf "fail2ban configured"

exit 0
