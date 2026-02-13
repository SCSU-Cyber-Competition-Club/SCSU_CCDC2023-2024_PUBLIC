#CHANGE THIS PATH NAME to whatever you'll be using as the folder for scripts...
$spaceScriptPath = "C:\Users\Administrator\Desktop\newScripts\SpaceUtilReport.ps1"

$spaceTaskName = "SpaceUtilizationReport"

#Define the trigger, AKA when/how often the file space script should run.
$spaceTrigger = New-ScheduledTaskTrigger -at 9AM -repetitioninterval (New-TimeSpan -Minutes 5) -repetitionduration "5" -once


#Run the file space script; ensure that it bypasses the script execution policy preventing unsigned scripts from running.
$spaceAction = New-ScheduledTaskAction -Execute "$spaceScriptPath" -Argument "-ExecutionPolicy Bypass"

#Run the script as administrator, which is required considering we're writing within the Administrator directory.
$spacePrincipal = New-ScheduledTaskPrincipal -UserId "Administrator" -RunLevel Highest

#Create the scheduled task, using settings defined above.
Register-ScheduledTask -Action $spaceAction -Trigger $spaceTrigger -Principal $spacePrincipal -TaskName $spaceTaskName

Start-ScheduledTask -TaskName $spaceTaskName

Write-Host "Scheduled task created. Reports will be generated every 10 minutes, and can be found in C:\Users\Administrator\Desktop\spaceReports" -ForeGroundColor Green