$spof = (Read-Host -Prompt "Enter it now." -AsSecureString)
get-aduser -filter {description -like "zCCDC"} |set-adaccountpassword -newpassword $spof -Reset
