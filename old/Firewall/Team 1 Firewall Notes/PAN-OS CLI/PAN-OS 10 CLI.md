
[PAN-OS CLI Quick Start](https://docs.paloaltonetworks.com/content/techdocs/en_US/pan-os/10-0/pan-os-cli-quick-start.html)
## CLI Modes

###### Operational Mode: 
Used to view information and logs. Can input operation commands to restart, load configurations, shutdowns and more.

###### Configuration Mode:
Used to view and modify the firewall configuration.

> To switch between Operational and configuration mode:

`configure`

```PAN-OS
username@hostname> configure
Entering configuration mode 
[edit] 
username@hostname#
```

> To exit configuration mode:

`quit`

```PAN-OS
username@hostname# quit
Exiting configuration mode 
username@hostname>
```

###### Scripting Mode
This mode you can copy and paste commands from a text file directly into the CLI.

```PAN-OS
username@hostname> set cli scripting-mode on
```

>To exit scripting mode

```PAN-OS
set cli scripting-mode off
```
## Basic Commands

###### Find Commands
`find command`: displays the entire command hierarchy.
`find command keyword <keyword>`: searches for commands that contain username in the command syntax.
###### Help Commands
`?`: you can get help on the specific command syntax by using the built-in CLI help. To get help, enter a `?` at any level of the hierarchy.

```PAN-OS
username@hostname# set deviceconfig system dns-setting ?
> dns-proxy-object Dns proxy object to use for resolving fqdns 
> servers Primary and secondary dns servers 
<Enter> Finish input
```

###### Set Terminal Output
`set cli config-output-format`: to change out put to JSON, XML, SET or Default.

###### User Accounts
`show mgt-config users`: Displays all current users
`set mgt-config users <admin> password`: Changes that users password
- [From the CLI can I update other admin account passwords?](https://live.paloaltonetworks.com/t5/general-topics/from-the-cli-can-i-update-other-admin-account-passwords/td-p/26668)
`delete mgt-config users <admin>`: Delete that users account
- [How to Delete an Admin Account From the Firewall Command Line](https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000PLcECAW)
`set mgt-config users <name> password`: Create a new account
`set mgt-config users <name> permissions role-based <role profile>`: Give a user a role (Like Admin)
- [How to Create Management Users, Assign Roles, and Change Password from the PAN-OS CLI](https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClFrCAK)

### Admin Accounts

###### Admin Timeout

`set cli timeout`: to change how long an administrative session can remain idle.


## Network Commands

###### Ping Command
Ping a device on the local network

`run ping host <IP>`

```PAN-OS
username@hostname# run ping host 10.1.1.2
PING 10.1.1.2 (10.1.1.2) 56(84) bytes of data 
... 
username@hostname#
```

###### Show Ethernet Interface Chart

`show network interface ethernet`

```PAN-OS
username@hostname>
configure
Entering configuration mode
[edit]
username@hostname# show network interface ethernet
ethernet {
	ethernet1/1 {
		virtual-wire;
	}
	ethernet1/2 {
		virtual-wire;
	}
	ethernet1/3 {
		layer2 {
			units {
				ethernet1/3.1;
			}
		}
	}
	ethernet1/4;
}
[edit]
username@hostname#
```

## Firewall Rules

[How to View, Create and Delete Security Policies on the CLI](https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000ClaCCAS)

###### Create a New Security Policy

`set rulebase security rules <name> from <source zone> to <destination zone> destination <ip> application <application> service <any/application-default/service name> action <allow/deny>`

> Example: `# set rulebase security rules Generic-Security from Outside-L3 to Inside-L3 destination 63.63.63.63 application web-browsing service application-default action allow (press enter)`

###### Show current Security Policy
`show running security-policy`

###### Create a Firewall Rule
`set rulebase security rules <Rule Name> from <Source Zone> to <Destination Zone> source any destination any application any service any action allow`


