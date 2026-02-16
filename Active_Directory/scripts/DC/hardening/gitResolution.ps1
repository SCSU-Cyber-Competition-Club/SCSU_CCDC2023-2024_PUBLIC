#HIGHLY SUGGESTED TO CHECK IF THIS NEEDS TO BE UPDATED, see below...
#This script ensures script downloads from Github work properly. This disables the IE Browser setting, and adds entries to the Hosts file.
#One entry for Github isn't enough; the collector. subdomain is (I'm pretty sure) utilized as well, and the render.githubusercontent.com URL certainly is.
#THESE IPs MAY REQUIRE UPDATING. Maybe not, but website change their servers/IPs sometimes. Ping these URLs and make sure they haven't.

#Disable IE Enhanced Security (browser setting preventing navigation to certain sites)



#Disable for admins
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
#Disable for non-administrative users
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}" -Name "IsInstalled" -Value 0
Stop-Process -Name Explorer -Force
Write-Host "IE ESC Disabled"






# Define variables for entries.
$ipGit = "140.82.114.4"
$hostGit = "github.com"

$ipColl = "140.82.114.22"
$hostColl = "collector.github.com"

$ipRend = "140.82.114.22"
$hostRend = "render.githubusercontent.com"
# Add entries to Hosts file. "'t" designates tab-separation between the IP and URL.
"$ipGit`t$hostGit`n$ipColl`t$hostColl`n$ipRend`t$hostRend" | Add-Content -Path "$env:windir\System32\drivers\etc\hosts" -Force
#"$ipColl`t$hostColl" | Add-Content -Path "$env:windir\System32\drivers\etc\hosts" -Force
#"$ipRend`t$hostRend" | Add-Content -Path "$env:windir\System32\drivers\etc\hosts" -Force