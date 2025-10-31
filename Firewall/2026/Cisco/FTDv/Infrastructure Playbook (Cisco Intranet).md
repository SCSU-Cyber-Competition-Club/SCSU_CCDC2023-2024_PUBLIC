
### Configure Network Objects (if not already done)

# ACL 0 (Lockdown)

---**Unrestricted**---
- NTP
- DNS (UDP Only)

---**Mgmt Lockdown**---
ALLOW any FROM Wkst TO FTDv
ALLOW any FROM FTDv TO Wkst

---**Script/Update Access**---
**DEPENDING ON WHAT WEB NEEDS**:
**MAY WANT TO DO THIS LAST (but in this order) TO SAVE TIME**
- ALLOW HTTPS FROM Web TO GH
- ALLOW HTTPS FROM GH TO Web
- ALLOW HTTPS FROM Web TO SysInt
- ALLOW HTTPS FROM Sysint TO Web
DENY HTTP FROM external TO Web
DENY HTTPS FROM external TO Web
DENY HTTP FROM Web TO External
DENY HTTPS FROM Web TO External
ALLOW HTTPS FROM external TO internal
ALLOW HTTPS FROM internal TO external

---**Internal Crosstalk**---
ALLOW any FROM internal TO internal

**DENY ALL FROM ALL TO ALL**

# ACL FINAL

- unrestricted:
	- NTP
	- ICMP (type6 or 8 or smthn)
	- DNS (**UDP only**)
- HTTP/S:
	- to/from external, Web
	- **DENY** all else
		- **only after everyone has grabbed scripts/ran updates**
- FTP:
	- to/from External, FTP
- **AD Ports**:
	- **TOWARDS THE END, FUCK AROUND WITH REMOVING THESE ALLOWS AND SEEING IF SCORING CONTINUES**
	- 88 (kpasswd)/LDAP(S)
		- to/from Any, AD
		- **LDAPS probably not needed, do last...**
	- 135
		- to internal from AD
		- **to AD from internal**
			- #  **RESTRICT THIS AS SOON AS ANOTHER MACHINE COMPROMISED**
	- SMB
		- to any FROM AD
- Cisco wkst:
	- to/from FTDv
- **deny rest**?


# Backups

- left-hand menu: `System Settings (or Devices) -> Backup/Restore`
- `Create Backup`
### VyOS
check for exploitable:
- routes
- extra interfaces
- fwall rules?

**checking routes**:
- `show ip route`
- **ideally, we don't want dynamic learning routes (BGP, EIGRP, OSPF...); route learning protocols are potential vulnerabilities**. (Per-user static route may be suspicious as well...) Code explanations are displayed when running `show ip route`
- routing to internet:
	- will look like `0.0.0.0/0 via <IP>, eth0`
	- **should certainly be static, may want to change if it's not**
# Workstation

see [[AD Playbook]]
### FTDv Persistence enumeration
in addition to stuff detailed above under VyOS:
- `/etc/init.d` entries
- `/ngfw/`
- `/var/sf/`

### FTDv Routing
`Devices -> Routing`