
# Designed to 
# .  ./util_github.ps1 -pullUpdates    Pull lastest vdiORchestration code into current folder"

param (
    [switch]$pullUpdates = $false
)

# Begin Variable block - Initializing--------------
# End Variable block - Initializing--------------


# Begin Function Logic-----------------------------------
# End Function Logic-----------------------------------

# Begin parameters main guardrail logic-----------------------------------
if ( $pullUpdates ) { 
    echo "`r`n---- Merging latest vdiORchestration code into current folder ----`r`n"
    
    # Remove any .git folders to break any connections
    if (Test-Path '..\.git' ) { Remove-Item '..\.git' -Recurse -Force }

    #initialize git, pull latest branches, the reset the head on local which updates all files
    set-location "../"
    Invoke-Expression "git init"
    Invoke-Expression "git remote add origin https://github.optum.com/IAC-COE/vdiOrchestration.git"
    Invoke-Expression "git fetch"
    Invoke-Expression "git reset --hard origin/master"

    # Remove any .git folders to break any connections
    set-location "powershell"
    if (Test-Path '..\.git' ) { Remove-Item '..\.git' -Recurse -Force }

    echo "`r`n---- Merge Completed: You may need to relink this folder back to the appropiate github repo ----`r`n"
}
else {
    echo "`r`n------------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "./util_github.ps1 -pullUpdates    Pull lastest vdiORchestration code into current folder"
    echo "------------------------------------------------------------------------------------------`r`n" 
}
# End parameters main guardrail logic-----------------------------------