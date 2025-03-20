# HONEYPOTTING! FUN! (Too fun. Please don't spend too much time doing this before you've got a solid Hardening playbook/understanding of Active Directory and the playbook.)
#Specifically, this script handles enable auditing for a specific file; as it is right now, when ANYONE either READS, EXECUTES, OR WRITES the file, whether SUCCESSfully
#doing so or FAILing (i.e. their account doesn't have permission), a log is created. Logs created from file access have Event IDs 4663. The next step is to use Task
#Scheduler to create a Scheduled Task, setting the trigger to be Event 4663s, and setting the action for the event to be... whatever you want. Get creative. I ran out of time,
#so mine didn't do much.

#Oh, and if you ARE going to do this, change the name of this script first, obviously. I just called it basicEnum.ps1 during the comp.
 function AddAuditToFile {
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$path
    )
    Get-Acl $path -Audit | Format-List Path,AuditToString | Out-File -FilePath 'file_before.txt' -Width 200 -Append
    $File_ACL = Get-Acl $path
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAuditRule("Everyone","ReadData, ExecuteFile, WriteData","none","none",”Success, Failure")
    $File_ACL.AddAuditRule($AccessRule)
    $File_ACL | Set-Acl $path
    Get-Acl $path -Audit | Format-List Path,AuditToString | Out-File -FilePath 'file_after.txt' -Width 200 -Append
    }

AddAuditToFile -path ./creds_FW_webmail.csv

