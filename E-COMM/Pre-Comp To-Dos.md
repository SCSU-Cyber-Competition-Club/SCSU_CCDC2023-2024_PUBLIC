# Pre-Comp To-Dos
### Pre-Comp Enumeration Checklist
*utilize this list when you have early access to comp env* 
- Credentialed Nessus Scans, (use various types)
- Identify Privileged Users & Groups
- Identify AS-Rep & Kerberostable accounts.
- Identify running services and know what services can be turned off (SMB)
- Identify processes making external connections (malware)
	- trace the malware to where its executing from
- Use Bloodhound (a great tool for finding various issues) to find additional issues with users, e.g., ACL, DCsync, etc.
- Look through both Local Group Policy and Domain Policy for unsecured set policies this will probably take some extra research.
- enumerate further for persistence, tasks, service, registry keys 
- is proper logging set up?
- is there plain text or sensitive files lying around?
- What current Records are set up in DNS? do further records need to be created or edited? 
