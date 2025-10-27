
download proxmox image, launch through VMWare (or whatever hypervisor, I used VMWare tho)
- beef it up with a little extra resources than you'll need for whatever VM(s) you'll be running within

launch proxmox, go through configuration process; afterwards...

launch proxmox, then go to IP it lists on the screen in your web browser

# FTD configuration

a **node** is a single machine (i.e. FTDv). a **cluster** is a group of VMs sharing resources


#### Import image to ProxMox

before configuring your image, you'll need to import the machine's image file (in our case, FTD's .qcow2 file)

easily done with `scp` (will need to download/install some implementation of it assuming you're on Windows)
- put the .qcow2 in `/var/lib/vz/images`


#### Initial configuration


now, click **Create VM** in the top right of ProxMox:
- name it whatever -> Next
- Click **Do not use any media** -> Next
- Select `Virto SCSI`, **NOT `Virtio SCSI Single**`; make sure machine is set to i440fx and BIOS is SeaBIOS -> Next
	- can't say for sure that these are actually necessary lol... but they work
- don't bother with Disks tab. -> Next
- any amount of sockets, but select **at least 4 cores**, and set Type t `host` -> Next
	- note that the total amount of cores you're actually allocating will be cores multiplied by sockets. 1 socket 4 cores is fine
- allocate RAM; Cisco recommends 8 GB minimum -> Next
- set the NIC model to **vmxnet3** -> Next
- confirm


#### Hard disk configuration 

not done yet. on the left side of proxmox, click on your cluster (should be called `pve`)

open the shell, and run these commands:
- **NOTE: VMID IS THE NUMBER NEXT TO THE NAME OF YOUR NODE (FTDv machine). It will be 100, assuming it's the first node yu're working with**
- `qm importdisk <vmid> /var/lib/vz/images/Cisco_Secure_Firewall_Threat_Defense_Virtual-7.2.0-82.qcow2 local-lvm`
	- this takes your .qcow2, imports it into a hard disk, saving it into your cluster's local storage, local-lvm, and attaches it to your node (which is identified by `<vmid>`)
- return to your browser. click on your node, then click on hardware
- you will see an IDE disk (or maybe it was a controller?... pretty sure it was a disk), an `unused disk 0`, and another `Hard Disk` (should be SCSI unless you changed settings on the Disks tab in initial configuration)
	- **Delete the IDE disk, and the disk that isn't the Unused Disk**. The latter was a hard disk that was created by default during the initial configuration. It is barren and useless. `Unused Disk 0` is the disk you just created using the .qcow2
- Click on the `Unused Disk`, make sure it's a scsi disk, then click OK. This will attach it properly to your VM.
	- you should now only see `Hard Disk (scsi0)`, and no longer see `Unused Disk 0` (as it is now `Hard Disk (scsi0))`
- open proxmox's shell again
	- type `qm set <vmid> --boot order=scsi0`
		- this ensures your machine tries to boot into that `Hard Disk (scsi0)` when you launch it
			- shouldn't be necessary at this point if you've deleted the other disks, but what the hell
	- type `qm set <vmid> --serial0 socket --vga serial0`
		- this gives your machine a serial interface, which it needs since FTDv is CLI-only


#### Network/NIC Configuration

FTDv should be able to launch now, but don't forget it will require four NICs to fully boot. Before you give it these NICs, you'll need to create their separate bridges (networks) in proxmox's shell.

Do so by editing the interfaces file. Type `nano /etc/network/interfaces`, then add the following to the file:

# Outside (WAN)
auto vmbr1
iface vmbr1 inet manual
    bridge-ports none
    bridge-stp off
    bridge-fd 0

# Inside (internal LAN)
auto vmbr2
iface vmbr2 inet manual
    bridge-ports none
    bridge-stp off
    bridge-fd 0

# DMZ
auto vmbr3
iface vmbr3 inet manual
    bridge-ports none
    bridge-stp off
    bridge-fd 0


save, and exit. Go back to FTDv's Hardware tab, click Add towards the top. It will already have one NIC on the vmbr0 bridge; give it three more, one on each of the three bridges you just created.


#### Serial Interface Configuation (and use)

Almost done. FTDv requires a serial interface, as it's CLI-only. In your shell, type `qm set <vmid> --serial0 socket --vga serial0`

Good to go now. Click on your machine and start it. **Every time you launch it, however**, you will need to attach to the serial interface; so, every time you launch it, open up ProxMox's shell and type `qm terminal <vmid>`.