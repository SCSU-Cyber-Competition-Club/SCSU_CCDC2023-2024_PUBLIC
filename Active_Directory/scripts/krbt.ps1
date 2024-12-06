# Specify the new password for the krbtgt account
$fauxPassword = ConvertTo-SecureString -String "*F734hAJFj@020FJf9" -AsPlainText -Force
$newPassword = ConvertTo-SecureString -String "!Thr3Eh34DeD_D0g" -AsPlainText -Force

# Change the password of the krbtgt account
Set-ADAccountPassword -Identity "krbtgt" -NewPassword $fauxPassword -Reset
Write-Host "First password change complete."
Set-ADAccountPassword -Identity "krbtgt" -NewPassword $newPassword -Reset
Write-Host "Second password change complete."



