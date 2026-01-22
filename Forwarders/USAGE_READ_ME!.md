## Linux Users

**THE SCRIPT WILL NOT WORK** unless you give it the proper arguments when calling:
- IP address of the Splunk host
- Username of the Splunk host's admin account
- Password of the Splunk host's admin account

So, **YOU WILL NEED TO GET THE CREDS FOR THE ADMIN ACCOUNT FROM WHOEVER'S RUNNING SPLUNK.**

Example> `./linuxSplunkForwarderInstall.sh 172.20.242.20 username password`

## Windows Users

The arguments are optional, and proper defaults have already been configured within the script (IP and your hostname). Just run the script; `./windowsSplunkForwarderInstall.sh`
