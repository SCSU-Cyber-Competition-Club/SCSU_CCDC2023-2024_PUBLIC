
### Run antivirus scans occasionally

### Monitor scheduled tasks (persistence):
cmdline:
- `schtasks /query`
- query specific task with `schtasks /query /tn "malwaretask"`

**Also Task Scheduler GUI**. Deletion of tasks is quickest here

### Monitor services
- GUI:
	- Start menu -> Services
- cmdline:
	- Query only running services: `sc query`
	- Query all services: `sc query state=all`
	- Query individual services: `sc query (SERVICENAME)`
##### Killing services in command line
- with name: `Stop-Service -Name "NAME" -Force`
- with display name (what shows up in Task Manager/Services): `Get-Service -DisplayName "<name>" | Stop-Service -Force`

### Monitoring processes
- Process Explorer sysinternals (ideal), Task Manager or `get-process`
- **Kill** in cmdline with `stop-process -id [ID]` (or `-name [NAME]`)

### Monitor Registry
- there are hundreds to comb through, and half you won't find on the Internet. Just rely on:
	- sysmon for monitoring registry changes
	- AutoRuns for monitoring registry locations that can be used for persistence







# Monitoring connections with netstat
- ### NOTE: TCPView (see below) is a much better alternative than this!
- display all connections/ports, in numeric form: `netstat -an`
- show executable involved with connection: `-b` (ex. `netstat -anb`)
- show owning process ID (PID): `-o`
- display routing table: `netstat -r`

### Monitoring logs in Event Viewer, including sysmon logs
Setting up sysmon:
- in pshell **(running as admin)**, go to directory with the sysmon .exe (config .exe needs to be present too)
- `.\sysmon64.exe -i -n -accepteula` (-n tells sysmon to log network connections)
- uninstall with `-u`
- load config with: `./sysmon64.exe -c sysmonconfig-export.xml`
	- this didn't work in lab... fine if it doesn't, but there'll be much more fluff

creates logs that can be found in Event Viewer
- `Application and Services Logs/Microsoft/Windows/Sysmon/Operational`
- RHS of Event Viewer, can filter logs, e.g. by event severity (probably don't need to always be looking at the hundreds of Informational logs). 


- event ID 11 (file creation) may not see files detected by antivirus
- event ID 22 (DNS queries) has very high volume. probably want to modify config to exclude all for this
event ID list:
- 1 - Process creation
- 2 - file creation time retroactively changed in filesystem
- 3 - network connection initiated
- 4 - sysmon service status messages
- 5 - process ended
- 6 - driver loaded into kernel
- 7 - dll image loaded by process
- 8 - remote thread created (process injecting code into other processes)
- 9 - raw disk access (cfg disabled for performance)
- 10 - inter-process access (cfg disabled for performance)
- 11 - file created
- 12 - reg object added/deleted
- 13 - reg value set
- 14 - reg object renamed
- 15 - alternate data stream created (other filesystem mininfilters can make it appear to sysmon some files being written twice)
- 16 - sysmon config change
- 17 - pipe created
- 18 - pipe connected
- 19 - WMIEventFilter activity detected
- 20 - WMIEventConsumer activity detected
- 21 - WMIEventConsumerToFilter activity detected
- 22 - DNS query **(disable this)**
- 23-25 - commented out


## Monitoring [[persistence]]
In addition to monitoring reg changes with sysmon, look at autoexecs with AutoRuns:
- autoruns64 or autoruns64a depending on processor (ARM or not)
- filtering in Options tab (e.g. hide files with Microsoft signature)
- can right click and "search online"


## Monitoring with TCPView
Sysinternals.
- very similar to netstat, but cleaner
- `View|Update Speed` to change update rate (default 1sec)
- yellow = endpoint changing state; red = endpoint deleted; green = new endpoint
- save output window to file with **Save** menu item
- can filter with:
	- protocol (TCPv4, UDPv6...)
	- Connection states (Closed, Listen, Ack...)
- can perform a WhoIs on selected connection
- can toggle on/off resolving of addresses (show IP or endpoint name, like DESKTOP-PG12HF8)

## Monitoring/preventing LDAP recon with LDAPFW
Logs generated can be found in Event Viewer
- unzip the zipped file
- move the config to same folder as the .exe
	- ### Use the DACLPrevention_config.json! Ignore the other.
- remove the default config.json file
- rename DACLPrevention..... to `config.json`
- PowerShell, navigate to that folder
- install with `./ldawfwmanager.exe /install`
- Verify with `./ldawfwmanager.exe /status`
- View all commands with `./ldapfwmanager.exe /help`

## Check processes spawned from cmd and PowerShell

`Get-WmiObject Win32_Process | Where-Object { $_.ParentProcessId -eq (Get-Process -Name powershell).Id } | Select-Object ProcessId, Name, CommandLine` 

`Get-WmiObject Win32_Process | Where-Object { $_.ParentProcessId -eq (Get-Process -Name cmd).Id } | Select-Object ProcessId, Name, CommandLine`

## Check system file integrity
- Pshell: `sigverif`
