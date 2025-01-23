# Specify the new password for the krbtgt account
$faux = ConvertTo-SecureString -String "*F734hAJFj@020FJf9" -AsPlainText -Force
$new = ConvertTo-SecureString -String "!Thr3Eh34DeD_D0g" -AsPlainText -Force

# Change the password of the krbtgt account
Set-ADAccountPassword -Identity "krbtgt" -NewPassword $faux -Reset
Write-Host "First change complete."
Set-ADAccountPassword -Identity "krbtgt" -NewPassword $new -Reset
Write-Host "Second password change complete."



