*Keep in mind after any change is made to the firewall rules a: `sudo firewall-cmd --reload` must be done* 

#### Using Firewalld`
`sudo systemctl enable firewalld
`sudo systemctl start firewalld`

#### Listing all active zones
`sudo firewall-cmd --get-active-zones`

#### Listing all Firewall rules
`sudo firewall-cmd --list-all`

*listing all rules for a zone*
`sudo firewall-cmd --list-all --zone=your_zone`
#### Allowing/Disallowing Necessary Services

- allowing
`sudo firewall-cmd --zone=public --add-service=http --permanent`

- Disallowing
 `sudo firewall-cmd --zone=yourzone --remove-service=your_service --permanent` 
#### Closing Unnecessary Ports
`suod firewall-cmd --zone=public --remove-port=8080/tcp --permanent`

#### Enable Logging
`sudo firewall-cmd --set-log-denied=all`

