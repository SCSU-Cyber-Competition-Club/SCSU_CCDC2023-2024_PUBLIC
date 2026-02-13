Get-ChildItem -Path . -Filter *.ps1 -File -Recurse |
  ForEach-Object {
    try {
      Unblock-File -Path $_.FullName
      Write-Host "Unblocked: $($_.FullName)"
    } catch {
      Write-Warning "Failed to unblock $($_.FullName): $_"
    }
  }
