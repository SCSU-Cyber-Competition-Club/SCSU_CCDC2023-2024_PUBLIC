
## 1. Enter Privileged EXEC Mode
Before making configuration changes, you need to enter privileged mode.
```bash
enable
```

## 2. Enter Global Configuration Mode
To configure the switch, enter global configuration mode.
```bash
configure terminal
```

## 3. Create a VLAN
Use the `vlan` command followed by the VLAN ID to create a new VLAN.
```bash
vlan <VLAN-ID>
```
**Example:**
```bash
vlan 10
```
This creates VLAN 10 on the switch.

## 4. Name the VLAN (Optional but Recommended)
Assigning a name to a VLAN improves readability and organization.
```bash
name <VLAN-NAME>
```
**Example:**
```bash
name DMZ
```
This names VLAN 10 as "SALES".

## 5. Exit VLAN Configuration Mode
After configuring the VLAN, exit VLAN mode.
```bash
exit
```

## 6. Assign a VLAN to an Interface
To assign a VLAN to a specific switch port, configure the interface in access mode and set the VLAN.
```bash
interface <INTERFACE-ID>
switchport mode access
switchport access vlan <VLAN-ID>
```
**Example:**
```bash
interface FastEthernet 0/1 or inter
switchport mode access
switchport access vlan 10
```
This assigns VLAN 10 to port `FastEthernet 0/1`.

## 7. Configure a Trunk Port (if needed)
If the switch needs to support multiple VLANs on an uplink or inter-switch connection, configure the interface as a trunk.
```bash
interface <INTERFACE-ID>
switchport trunk encapsulation dot1q
switchport mode trunk
switchport trunk allowed vlan <VLAN-ID(s)>
```
**Example:**
```bash
interface GigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan 10,20,30
```
This sets `GigabitEthernet 0/1` as a trunk port and allows VLANs 10, 20, and 30.

## 8. Save the Configuration
After making changes, save the configuration to prevent loss after a reboot.
```bash
copy running-config startup-config
```

