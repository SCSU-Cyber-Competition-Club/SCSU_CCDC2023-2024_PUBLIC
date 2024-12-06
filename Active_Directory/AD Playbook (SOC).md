### Monitor scheduled tasks (persistence):
- `schtasks /query`
- query specific task with `schtasks /query /tn "malwaretask"`

### Monitor services
- GUI:
	- Start menu -> Services
- cmdline:
	- Query only running services: `sc query`
	- Query all services: `sc query state=all`
	- Query individual services: `sc query (SERVICENAME)`

### Monitor Registry Editor
- Yeah... for now, the title of this section is actually an instruction. Keep an eye on this. All I got for now. Regedit spooky.

### Killing services/scheduled tasks
- with name: `Stop-Service -Name "NAME" -Force`
- with display name (what shows up in Task Manager/Services): `Get-Service -DisplayName "Windows Update" | Stop-Service -Force`
- **with PID** (see below): `Stop-Process -Id 1234`


# Monitoring connections with netstat
- display all connections/ports, in numeric form: `netstat -an`
- show executable involved with connection: `-b` (ex. `netstat -anb`)
- show owning process ID (PID): `-o`
- display routing table: `netstat -r`



