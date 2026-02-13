#!/usr/bin/env bash

while IFS=: read -r username _ uid _; do
    if [ "$uid" -ge 5000 ]; then #if uid is greater than or equal to 5000
        usermod $username -s /sbin/nologin;
    	printf "$username, user set to no login \n";
    fi
done < /etc/passwd
