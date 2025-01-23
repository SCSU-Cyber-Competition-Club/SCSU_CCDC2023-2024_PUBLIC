Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
Set-SmbServerConfiguration -EnableSMB3Protocol $false -Force
Write-Host "SMB disabled through its configuration. Make sure to disable it through Services as well...."

