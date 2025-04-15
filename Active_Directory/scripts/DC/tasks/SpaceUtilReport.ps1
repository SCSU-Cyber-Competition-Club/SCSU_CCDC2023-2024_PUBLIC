#You're gonna need to make some modifications to this; this just serves as a skeleton to save you some time.
#I can't remember exactly what the inject asked for. This script generates a report as a text file and saves it to Admin's
#Desktop directory, in a folder it generates if it doesn't already exist.
#Furthermore, it's giving me a "permission denied" error even when setting the path to a low-level user's directory, and running
#Powershell as Admin; when executing with the scheduled task wtih highest privileges, a text file pops up that just shows this
#script itself, rather than the report I'm trying to generate. I Am Losing My Mind.
#At the very least, you could easily just have this run and output the results with Write-Host rather than saving a text file. 


#Create a folder for reports generated if it isn't already present.
$folderPath = "C:\Users\Peter\Desktop\spaceReports\report"
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
}
else {}

$timestamp = Get-Date -Format "yyyy-MM-Ddd HH:mm:ss"

#Gets info on a drive to be monitored (in this script's case, the C: drive) and stores into a variable.
$driveDet = Get-PSDrive C

#Gets individual values, used space and free space, from previous command and puts them into variables.
$usedSpace = $driveDet.Used
$freeSpace = $driveDet.Free

#Calculate percentage of space utilized.
$spaceTotal = $usedSpace + $freeSpace
$usedPercent = $usedSpace / $spaceTotal

#Generate report.
$spaceReport = @"
Disk Space Report (Generated $timestamp)
Total space: $spaceTotal
Used space: $usedSpace
Free space: $freeSpace
Percentage of space utilized: $usedPercent
"@

#Write the report in the spaceReport folder.
$spaceReport | Out-File -FilePath $folderPath -Encoding UTF8

