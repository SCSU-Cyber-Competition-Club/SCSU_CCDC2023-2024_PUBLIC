# Specify the drive or path to search (e.g., C:\ or D:\)
$path = Read-Host "Enter the drive (or directory path) to begin the search."

# Start at the beginning of the path, recursively search for all files; continue without creating error messages for folders/files where perm is denied
Get-ChildItem -Path $path -Recurse -File -ErrorAction SilentlyContinue | 
    Where-Object {
        #ACL = Access Control List; list of Permissions info
        $acl = Get-Acl -Path $_.FullName
        $acl.Access | Where-Object {
            # Check for "Everyone" group with Read or Write permissions
            ($_.IdentityReference -eq "Everyone" -or $_.IdentityReference -eq "NT AUTHORITY\Everyone") -and
            ($_.FileSystemRights -match "Read" -or $_.FileSystemRights -match "Write" -or $_.FileSystemRights -match "Modify" -or $_.FileSystemRights -match "FullControl")
        }
    } | 
    
    # For the output, we will be grabbing two things. First is the FullName (path) of the file. For the second, we're creating a custom property, Permissions.
    # To define how this Permissions property is created, we create an expression. First, we access the ACL for this object.
    # We then filter out ACL info not related to Public (Everyone) access.
    # Finally, we choose the properties from this ACL to put into this Permissions column: IdentityReference, and the associated rights.
    Select-Object FullName, @{Name="Permissions";Expression={(Get-Acl $_.FullName).Access | Where-Object {($_.IdentityReference -eq "Everyone" -or $_.IdentityReference -eq "NT AUTHORITY\Everyone") } | Select-Object -Property IdentityReference, FileSystemRights}}