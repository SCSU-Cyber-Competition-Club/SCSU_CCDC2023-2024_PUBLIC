$installerFile = Get-ChildItem -Path C: -Recurse -Filter "*.exe" | Where { $_.Name -match "MBSetup.exe" }
$installerPath = $installerFile.FullName
start-process $installerPath -argumentlist "/nocancel /verysilent /suppressmsgboxes"