
### Examine Log Files
- Monitor > Logs > System

### Create a Log File Filter
- `( subtype eq vpn )`
- `(severity eq informational)`
- Use the plus icon to use Filter Builder


### ### Set Up Zone Protection
- Network > Network Profiles > Zone Protection > Add
- Name
- Flood Protection
### Set Up DoS Protection
- Objects > Security Profiles > DoS Protection > Aggregate
	-  Flood Protection > Enable all Flood Protections
	- Resource Protection > Enable Max quota from a host
- Create a Dos Policy (Random Early Drop)
	- Policies > Add
	- General = Name
	- Source = Internet
	- Destination = Internal
	- Option/Protection:
		- Action = Deny
		- Aggregate =  Dos Protection Profile

[How to perform a factory reset on a Palo Alto Networks device from Maintenance Mode](https://knowledgebase.paloaltonetworks.com/KCSArticleDetail?id=kA10g000000CldXCAS)

![FirewallGIF](https://c.tenor.com/7fV44QRzGTsAAAAC/tenor.gif)