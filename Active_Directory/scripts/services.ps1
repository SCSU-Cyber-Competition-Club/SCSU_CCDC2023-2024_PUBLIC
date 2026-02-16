#Risky services that need to be disabled (and can be).
#I'm going to leave a few in here that are risky, but CAN'T be disabled without breaking our environment to save you the time
#of finding these while doing your own research and ultimately seeing they sholudn't be disabled.
#These will be commented out. If you want to help other teams shoot themselves in the foot, remove these from the script
#before you have to make the Github public to others, in case they were planning on disabling them.

#READ THIS!
#Disabling Remote Registry will cause some scary-looking errors in your Server Manager, particularly concerning DFS Namespace.
#This will break the ability for file shares in your environment. HOWEVER, the domain will keep limping on as much as we need it to
#for the competition.
#If you happen to get some inject requiring setting up a file share, remember to reenable and start (easy in the Services GUI).
Stop-Service -Name "RemoteRegistry" -Force
Set-Service -Name "RemoteRegistry" -StartupType Disabled


Write-Host "Disabling naughty services..." -ForeGroundColor Red
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

#Remote Procedure Call (RPC)
#This isn't just required for domain controller functionality, this is required for WINDOWS functionality.
#Even disabling this on your Windows desktop sitting at home will cause a lot of issues.
#Stop-Service -Name "RpcSs" -Force
#Set-Service -Name "RpcSs" -StartupType Disabled

#Compatability with LEGACY RPC; as such, disabling is fine in our environment.
#Stop-Service -Name "RpcLocator"
#Set-Service -Name "RpcLocator" -StartupType Disabled

#Routing and Remote Access
Stop-Service -Name "RemoteAccess" -Force
Set-Service -Name "RemoteAccess" -StartupType Disabled

#Definitely an attack vector, but needed for a domain controller.
#Stop-Service -Name "WinMgmt"
#Set-Service -Name "WinMgmt" -StartupType Disabled

#Print Spooler
Stop-Service -Name "Spooler"
Set-Service -Name "Spooler" -StartupType Disabled

#SMB
#Again, huge attack vector, but needed as DC. See smb.ps1 for how we utilize SMB as safely as possible.
#Stop-Service -Name "LanmanServer" -Force
#Set-Service -Name "LanmanServer" -StartupType Disabled
#Stop-Service -Name "LanmanWorkstation" -Force
#Set-Service -Name "LanmanWorkstation" -StartupType Disabled

Write-Host "Risky services disabled." -ForeGroundColor Red

#RA Connection Manager. This is hard to stop even with force for some reason...
#Stop-Service -Name "RasMan" -Force
#Set-Service -Name "RasMan" -StartupType Disabled
