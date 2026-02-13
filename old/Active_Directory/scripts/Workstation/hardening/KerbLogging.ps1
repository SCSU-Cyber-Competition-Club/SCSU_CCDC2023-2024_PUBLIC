#Enables logging of Event IDs 4768 (TGT requests) and 4769 (TGS requests).
auditpol /set /category:"Account Logon" /subcategory:"Kerberos Service Ticket Operations" /success:enable /failure:enable
auditpol /set /category:"Account Logon" /subcategory:"Kerberos Authentication Service" /success:enable /failure:enable

#Increase maximum space utilized for security logs to 3.96 GB. Most you can do is 4GB, and size must be in increments of 64KB,
#hence the weird number.
#Also, note that there's a bug in Event Viewer; after running this command, the change will not be reflected in the Event Viewer GUI.
#The change is reflected after a restart, however.
#If you're not confident that the change simply isn't showing up, but rather it's not applying till a restart, you could restart.
#However, considering the command isn't receiving any errors after executing this, I'm 99% sure it's applying, just not showin' up.
Limit-EventLog -Logname Security -MaximumSize 3960000KB
