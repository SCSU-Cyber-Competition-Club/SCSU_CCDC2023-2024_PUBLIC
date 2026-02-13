#Three steps to the TCP Handshake: Host sends SYN, recipient responds with SYN/ACK, client confirms connection by sending ACK.
#This command finds TCP connections in the state where the client has sent the first SYN packet and is waiting,
#or the recipient has sent a SYN/ACK and is waiting for the final ACK.
#Relevant information on the connection is then returned as output.
#Note that all of this information could be found through the TCPView sysinternals tool. This just streamlines the process
#for this specific use case.

Get-NetTCPConnection | Where { $_.State -in @('SynSent', 'SynReceived') } | Select-Object OwningProcess, LocalAddress, LocalPort, RemoteAddress, RemotePort, State