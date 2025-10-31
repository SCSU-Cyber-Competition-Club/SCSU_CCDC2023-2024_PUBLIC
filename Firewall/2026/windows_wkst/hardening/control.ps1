#This script will not be needed if we fully realize the vision of Honorable Monkey. (This justs executes all of the scripts.)
#If this vision is not realized (or it is not ready yet by the time of your competition), two things are required of you:
#1. Add lines for all of the hardening scripts you're bringing into the comp, and remove ones for scripts that might be here but aren't being used anymore
#2. Ensure this script is in the same directory as the hardening scripts
#& "./firewall.ps1"
& "./KerbLogging.ps1"
& "./llmnr.ps1"
& "./netbios.ps1"
& "./services.ps1"
& "./firewall.ps1"
#& "./smb_client.ps1"
& "./sysminstall.ps1"




