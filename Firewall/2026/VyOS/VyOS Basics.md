https://forum.vyos.io/t/download-page-for-vyos/12255/3

`?` for available commands

tabplete

https://docs.vyos.io/en/latest/cli.html

operational (default) and configuration mode; enter configuration with `configure`
- exit with `exit`; discard changes with `exit discard`

# Operational families
#### clear[](https://docs.vyos.io/en/latest/cli.html#clear "Link to this heading")

“Clear” commands are completely non-disruptive to any system operations. Generally, they can be used freely without hesitation.

Most often their purpose is to remove or reset various debug and diagnostic information such as system logs and packet counters.

#### reset[](https://docs.vyos.io/en/latest/cli.html#reset "Link to this heading")

“Reset” commands can be locally-disruptive. They may, for example, terminate a single user session or a session with a dynamic routing protocol peer.

They should be used with caution since they may have a significant impact on a particular users in the network.

#### restart[](https://docs.vyos.io/en/latest/cli.html#restart "Link to this heading")

“Restart” operations may disrupt an entire subsystem.

#### force[](https://docs.vyos.io/en/latest/cli.html#force "Link to this heading")

“Force” commands force the system to perform an action that it might perform by itself at a later point.

# Configuration

3 config types:
- **Active** or **running configuration** is the system configuration that is loaded and currently active
	- show with `show configuration`
	- `show configuration commands` **shows all the set commands that were needed for the current config**
- **Working configuration** is the one that is currently being modified in configuration mode.
- **Saved configuration**

**you're entering a tree structure in config mode**; in the same way you could, example `cat` stuff deep within your filesystem which would make the commands lengthy, you can do everything from the top level, but commands would be quite long

as such, use `edit` to navigate the tree structure
- `top` or `exit` to go to top of tree
- `up` to go back one

`show` command within configuration mode will show the working configuration indicating line changes with `+` for additions, `>` for replacements and `-` for deletions.
- can also show | commands to see all `set` commands specifically
- these are relative to the level you're in

after `set`ting a config change:
- `commit`
	- `commit confirm <minutes` to give it x amount of minutes before change isn't saved if you don't `confirm`; during those minutes, can
		- `reload` to stop timer and go back to previous cfg
		- `reboot` to saved cfg
- `save`

`copy`

`vyos@router# show firewall name FromWorld
 `default-action drop
 `rule 10 {
    `` action accept
     `source {
        `` address 203.0.113.0/24
     `}
`` }
`[edit]
`vyos@router# edit firewall name FromWorld
`[edit firewall name FromWorld]
`vyos@router# copy rule 10 to rule 20
`[edit firewall name FromWorld]
`vyos@router# set rule 20 source address 198.51.100.0/24
`[edit firewall name FromWorld]
`vyos@router# commit
`[edit firewall name FromWorld]

`rename`
- `vyos@router# rename rule 10 to rule 5

`comment`

vyos@vyos# comment firewall all-ping "Yes I know this VyOS is cool"
vyos@vyos# commit
vyos@vyos# show
 firewall {
     /* Yes I know this VyOS is cool */
     all-ping enable
     broadcast-ping disable
     ...
 }

`run`
- to execute op mode commands in cfg mode

`compare`
- compare revisions
- `compare [tab]` to see options
- see them w/ `show system commit`
- can `rollback <N>`

### Can upload configuration to remote location (FTP, SCP, etc...)



