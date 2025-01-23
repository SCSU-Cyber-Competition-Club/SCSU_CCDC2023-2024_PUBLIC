#Service names were provided by ChatGPT. These need to be tested before used in comp.


#RA Auto Connection Manager
Stop-Service -Name "RasAuto" -Force
Set-Service -Name "RasAuto" -StartupType Disabled



#RD Configuration AND RD Services
#AKA, this is the actual RDP service
Stop-Service -Name "TermService" -Force
Set-Service -Name "TermService" -StartupType Disabled

#Remote Desktop Services UserMode Port Redirector
Stop-Service -Name "UmRdpService" -Force
Set-Service -Name "UmRdpService" -StartupType Disabled

#RPC
#TEST TEST TEST
#Stop-Service -Name "RpcSs" -Force
#Set-Service -Name "RpcSs" -StartupType Disabled

#Compatability with legacy RPC; as such, disabling shouldn't cause any issues (like with disabling Rcpss)
Stop-Service -Name "RpcLocator"
Set-Service -Name "RpcLocator" -StartupType Disabled

Stop-Service -Name "RemoteRegistry" -Force
Set-Service -Name "RemoteRegistry" -StartupType Disabled

#Routing and Remote Access
Stop-Service -Name "RemoteAccess" -Force
Set-Service -Name "RemoteAccess" -StartupType Disabled

#TEST, WILL PROBABLY BREAK
#Stop-Service -Name "WinMgmt"
#Set-Service -Name "WinMgmt" -StartupType Disabled

#Print Spooler
Stop-Service -Name "Spooler"
Set-Service -Name "Spooler" -StartupType Disabled

#simple service discovery protocol
Stop-Service -Name "sspdsrv" -Force
Set-Service -Name "ssdpsrv" -StartupType Disabled

#SMB
Stop-Service -Name "LanmanServer" -Force
Set-Service -Name "LanmanServer" -StartupType Disabled
Stop-Service -Name "LanmanWorkstation" -Force
Set-Service -Name "LanmanWorkstation" -StartupType Disabled

#RA Connection Manager. This is hard to stop even with force for some reason...
Stop-Service -Name "RasMan" -Force
Set-Service -Name "RasMan" -StartupType Disabled
