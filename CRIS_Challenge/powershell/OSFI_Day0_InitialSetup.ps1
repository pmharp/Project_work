
# Designed to 
# .  ./OSFI_Day0_InitialSetup.ps1 -day1         Setup all files for the initial work
# .  ./OSFI_Day0_InitialSetup.ps1 -resetTF      Reset for a TF run (remove .terraform folder, etc)
# .  ./OSFI_Day0_InitialSetup.ps1 -resetAll     Reset All, reset back to factory defaults

param (
    [switch]$day1 = $false,
    [switch]$resetTF = $false,
    [switch]$resetAll = $false
)

# Remove all Placeholder.txt files and the link to github repo
if (Test-Path '..\.git' ) { Remove-Item '..\.git' -Recurse -Force }
if (Test-Path '..\OSFI_InitialBuilds\.terraform' ) { Remove-Item '..\OSFI_InitialBuilds\.terraform' -Recurse  -Force } 
set-location "../"
Get-childItem -Recurse -Filter placeholder.txt | Remove-Item  -Force
set-location "powershell"

if ( $day1 ) { 
    # Remove folders/files regardless if existance, user  process modded them - unknown base
    if (Test-Path '..\OSFI_InitialBuilds' ) { Remove-Item '..\OSFI_InitialBuilds' -Recurse  -Force }
    Copy-Item -Path "..\ZZBaseFiles\Day1Work\OSFI_InitialBuilds"  -Recurse -Destination "..\" -Container 
    if (Test-Path '..\OSFI_InitialBuilds\*_0.tf' ) { Remove-Item '..\OSFI_InitialBuilds\*_0.tf' -Recurse  -Force }

    echo "`r`n---------------Codebase Ready For Modification ---------------"
    echo " OSFI_InitialBuilds:  Initial server builds"
    echo "--------------------------------------------------------------`r`n"
}
elseif ( $resetTF ) { 
    if (Test-Path '..\OSFI_InitialBuilds\.terraform' ) { Remove-Item '..\OSFI_InitialBuilds\.terraform' -Recurse  -Force } 
}
elseif ( $resetAll ) { 
    if (Test-Path '..\OSFI_InitialBuilds' ) { Remove-Item '..\OSFI_InitialBuilds' -Recurse  -Force } 
}
else {
    echo "`r`n--------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "./OSFI_Day0_InitialSetup.ps1 -day1         Setup all folder/files for the initial work"
    echo "./OSFI_Day0_InitialSetup.ps1 -resetTF      Reset for a TF run (remove .terraform folder, etc)"
    echo "./OSFI_Day0_InitialSetup.ps1 -resetAll     Reset All, reset back to factory defaults"
    echo "--------------------------------------------------------------------------------------`r`n" 
}