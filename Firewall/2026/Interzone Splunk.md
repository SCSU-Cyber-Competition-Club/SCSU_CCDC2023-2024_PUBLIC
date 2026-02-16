
# Routing

routing will likely already be present, check with `show ip route` on VyOS, you should see something like:
`C>* <Palo subnet> is directly connected, eth1`
`C>* <Cisco subnet> is directly connected, eth2`

**both subnets being directly connected means that a route will be present**.

additionally, static routes (or dynamic routes, though these are vulnerable) between the two will do the job as well

if it's not, set a route with:

`set protocols static route <Cisco subnet> next-hop <Palo subnet>`
`commit; save`

if NAT happens on router's **external** interface, it shouldn't cause any issues

if NAT is happening on firewalls, however, two options:
1. (easier, more sure that it'll work)
	1. just use Public IPs, for:
		1. **executing script** on Windows machine
		2. Cisco rule allowing traffic out
		3. Palo rule allowing traffic in
2. static or identity NAT object on Cisco:
	1. Source NAT Type: Static or Identity
	2. Original Source: `<Cisco subnet>`
	3. Translated Source: `<Cisco subnet>`
		1. in others words: "When doing NAT conversion on IPs within the Cisco subnet, convert it to the same IP"
			1. in shorter words: don't change the IPs through NAT
	4. (see below for where to go to do this)

### REMEMBER:
- there may be security configs in place already preventing interzone traffic
	- firewall rules on firewalls/VyOS
	- lack of route between zones

# NAT rule

Policies -> NAT

select Manual 

see above

------------------
Not done yet; allow the traffic through the firewalls:

# FTDv

rule:
- ALLOW 9997 FROM internal TO Splunk
	- dest zone will be external?

# Palo

rule:
- ALLOW 9997 FROM external TO Splunk
	- specifying the Cisco subnet rather than all of external would be more secure


# Added security
# Splunk

edit `inputs.conf`:
- acceptfrom = `<Cisco subnet>`
	- or maybe this is needed, if it's already configured to only allow whitelists...
	- otherwise, this is just defense-in-depth if you specified allowing only traffic from Cisco's subnet in the Palo rule already