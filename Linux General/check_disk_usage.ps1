#!/usr/bin/pwsh

#NEED TO TEST THIS!!!!!

# Get disk usage for the root filesystem
$diskUsage = df -h / | Select-Object -Skip 1 | ForEach-Object { ($_ -split '\s+')[4] }

# Output the percentage used
Write-Output "Disk Usage: $diskUsage used"