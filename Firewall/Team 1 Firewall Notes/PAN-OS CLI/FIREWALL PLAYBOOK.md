# First 15

1. Change Administrator Password
	* `configure`
	* `set mgt-config users <admin> password`
	> Example below:
	
```PAN-OS
admin@lab-firewall> configure
admin@lab-firewall# set mgt-config users adminTest password
Enter password:
Confirm password:

[edit]
admin@lab-firewall# exit
Exiting configuration mode
admin@lab-firewall>
```

2. Check other user accounts
	* `show mgt-config users`
	* Delete any unknown accounts
	* `Delete mgt-config users <admin>`

3. Check current Interfaces
	- `show interface all`
	- If they are already made great!
	- Make three new interfaces.
		- `set zone <zonename>`
		- `set zone <zonename> network layer3 <eth>`

4. Import Firewall Config
	 - Device > Setup > Operations
	 - Import named configuration snapshot
	 - Load named configuration snapshot
	 - Commit

5. Apply ACL Rules to Firewall
	- `set rulebase security rules <Rule Name> from <Source Zone> to <Destination Zone> source any destination any application any service any action allow`
	- For all rules in our ACL


6. Monitor Logs and IDS plus Injects