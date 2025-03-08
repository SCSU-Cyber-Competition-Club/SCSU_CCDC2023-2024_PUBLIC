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

