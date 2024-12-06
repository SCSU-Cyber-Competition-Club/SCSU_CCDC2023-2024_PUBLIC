Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
Write-Host "SMB versions 1 and 2 disabled. Unclear whether or not SMB is required at all. `n If not, disable SMBv3 with: `n Set-SmbServerConfiguration -EnableSMB3Protocol $false -Force"
#Set-SmbServerConfiguration -EnableSMB3Protocol $false -Force