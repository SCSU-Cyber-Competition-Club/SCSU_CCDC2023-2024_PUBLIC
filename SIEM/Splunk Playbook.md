## Note:
Forwarders will create a least-privilege account upon installation. This account should be used when **running** the forwarder, **not** a root or admin account. **These accounts have default passwords that must be hardened.**
- Windows creates `splunkforwarder` account
	- change password with `Set-ADAccountPassword -Identity splunkforwarder -NewPassword (ConvertTo-SecureString -AsPlainText "newpassword" -Force)`
- Linux creates `splunkfwd` account
	- change password with `sudo passwd splunkfwd`
		- switch to this user to run, with `su splunkfwd`

## Configure indexer:
- Settings Tab -> Data -> Forwarding and Receiving
- Receive Data -> Configure Receiving -> Add New
- Select a receiving port **9997**

## Linux forwarder:
if it's a tar file we downloaded, will have to untar:
		- sudo tar xzvf `filename` `destination`
	- navigate to the bin directory **within the forwarder** (e.g. ...splunkforwarder/bin)
	- ./splunk start --accept-license
	- setup admin account credentials (not the same as indexer instance)
		- **record these...**
	- ensure forwarder starts whenever system reboots:
		- ./splunk enable boot-start -user `user`
			- NOTE: I BELIEVE `user` is your user in linux, e.g. `splunkfwd`?
	- configure it with the indexer:
		- ./splunk add forward-server `IndexerIP:IndexerReceivingPort`
			- port should be 9997...
	- configure what data to send (**Deciding on this is gonna be the tricky part. See the section below for recommendations I found.**)
		- ./splunk add monitor -auth `SplunkAdminUsername:SplunkAdminPassword` `PathToLog` (e.g. /opt/log/)
	- `OPTIONAL` back to indexer, verify it's forwarding:
		- Summary tab -> Data summary -> Sources tab
- ### Setting up Windows forwarder:
	- install, run through installer:
		- skip "Deployment server" step. We don't have this.
	- configure what data to send:
		- go to indexer (yes, configuring this on kali indexer, not on windows)
		- Setting Tab -> Add data -> Forward
		- Note: May take a bit for the Windows forwarder to show up on this screen
		- Select Windows host -> type a New Server Class Name
		- Click Next (green button top of page)
		- Click Local Event Logs
		- Select the logs we want to view
		- # Again, need to figure out which logs we want here!!!
		- **May** need to create a new index for these Win logs
		- ## And may need to do this for linux too...??
		- Click Next through Review
		- **Click "Start Searching"**
		- ## Maybe need to do that for Linux too? (though this might not actually be starting the service, just used to start looking idk)

## Some good logs we might want to send:
- ### Generally speaking, everything we should want to send from Linux will probably be in /var/log or /opt/log. The logs listed below should be in /var/log
- auth.log
- secure
- syslog
- messages
- audit/audit.log
- cron
- selinux
- sudo.log