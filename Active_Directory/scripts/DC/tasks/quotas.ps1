#File Server Resource Manager (FSRM) WILL NEED TO BE INSTALLED MANUALLY first, through "Add Roles and Features" in Server Manager.
#MAKE SURE TO CHECK THE BOX TO INCLUDE MANAGEMENT TOOLS. This is the issue preventing me from installing FSRM through Powershell.
#Theoretically, this should be able to be done by additionally installing RSAT through Powershell,
#which serves as the FSRM management tools... but for whatever reason, FSRM still doesn't launch when doing so.

function NewQuota {
    $qName = Read-Host "Enter the quota name."
    
    #Hard limits will not allow the user to perform an action that will result in the specified size quota being exceeded.
    #Additionally, a threshold is specified (in percentage of the limit) at which an alert is created.
    #This script will handle alerts through generating logs viewable in Event Viewer. Alternatively, they can be handled
    #by sending an email, or executing a command/script.
    $enforce = Read-Host "Should this quota include a hard limit that cannot be exceeded? ('y' or 'n')"
    
    

    if ($enforce -eq 'y' -or $enforce -eq 'Y') {
        $qHard = Read-Host "Enter the quota hard limit. (Ex. 1 MB = 1000000 (1 million))"
        $qSoft = Read-Host "Enter the threshold, in percentage (without a % sign), a log should be generated."
        $qDir = Read-Host "Enter the directory path to apply the quota to. (Example: C:\Users\Administrator)"
	    #Specifies an event log should be generated when threshold is exceeded, and the warning message found in the log.
        $qAction = New-FSRMAction Event -EventType Information -Body "WARNING: Quota threshold exceeded for directory."
        #Creates a threshold, and specifies the action it should take is the action specified above.
        $qThreshold = New-FsrmQuotaThreshold -Percentage $qSoft -Action $qAction

        New-FSRMQuota -Path $qDir -Size $qHard -Threshold $qThreshold
    }
    else {
        $qSize = Read-Host "Enter the quota soft limit in bytes. (Ex. 1 MB = 1000000 (1 million))"
        $qDir = Read-Host "Enter the directory path to apply the quota to. (Example: C:\Users\Administrator)"
        $qAction = New-FSRMAction Event -EventType Information -Body "WARNING: Quota threshold exceeded for directory."
        #Since soft limits only serve the purpose of generating alerts, this script simply sets the threshold at 100% to the
        #specified size for soft limits.
        $qThreshold = New-FsrmQuotaThreshold -Percentage 100 -Action $qAction

        New-FSRMQuota -Path $qDir -Size $qSize -Threshold $qThreshold -SoftLimit
    }
    $qAnother = Read-Host "Would you like to create another quota? ('y' or 'n')"
    if ($qAnother -eq 'y' -or $qHard -eq 'Y') {
        NewQuota
    }
    else {}
}

NewQuota

Write-Host "Quota completion complete. Details can be viewed quickest through typing File Server Resource Manager in the search bar." -ForeGroundColor Green
Write-Host "Event logs related to quotas can be found in the Application logs in Event Viewer. Filter by source: SRMSVC." -ForeGroundColor Green




