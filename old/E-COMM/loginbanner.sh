#!/bin/bash

echo -e '\u001b[31m \nWARNING! Access to this device is restricted to those individuals with specific Permissions. If you are not an authorized user, disconnect now.
Any attempts to gain unauthorized access will be prosecuted to
the fullest extent of the law.\n\u001b[0m' | tee -a /etc/issue /etc/issue.net >> /dev/null

echo -e "\u001b[31m \nThis computer system is for authorized users only. Individuals using this
system without authority or in excess of their authority are subject to
having all their activities on this system monitored and recorded or
examined by any authorized person, including law enforcement, as system
personnel deem appropriate. In the course of monitoring individuals
improperly using the system or in the course of system maintenance, the
activities of authorized users may also be monitored and recorded. Any
material so recorded may be disclosed as appropriate. Anyone using this
system consents to these terms.\n\u001b[0m" >> /etc/motd

echo "Banner /etc/issue.net" >> /etc/ssh/sshd_config
