# Specify the new password for the krbtgt account
$faux = (Read-Host -Prompt "First one..." -AsSecureString)
$new = (Read-Host -Prompt "Second now." -AsSecureString)

# Change the password of the krbtgt account
Set-ADAccountPassword -Identity "krbtgt" -NewPassword $faux -Reset
Write-Host "First change complete."
Set-ADAccountPassword -Identity "krbtgt" -NewPassword $new -Reset
Write-Host "Second change complete."



