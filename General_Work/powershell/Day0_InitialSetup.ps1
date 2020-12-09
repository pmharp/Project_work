
# Designed to 
# .  ./Day0_InitialSetup.ps1 -day1     Setup all files for the initial work
# .  ./Day0_InitialSetup.ps1 -resetTF  Reset for a TF run (remove .terraform folder, etc)
# .  ./Day0_InitialSetup.ps1 -resetAll Reset All, reset back to factory defaults

param (
    [switch]$day1 = $false,
    [switch]$resetTF = $false,
    [switch]$resetAll = $false
)

# Begin Variable block - Initializing--------------
$noOutput = ""       # Used to mask output to screen for system functions
# End Variable block-----------------------------------

# Remove all Placeholder.txt files, .terraform folder from init and link to github repo
if (Test-Path '..\.git' ) { Remove-Item '..\.git' -Recurse -Force }
if (Test-Path '..\Day1_InitialBuilds\.terraform' ) { Remove-Item '..\Day1_InitialBuilds\.terraform' -Recurse  -Force } 
set-location "../"
Get-childItem -Recurse -Filter placeholder.txt | Remove-Item  -Force
set-location "powershell"

if ( $day1 ) { 
    # Remove folders/files regardless if existance, user  process modded them - unknown base
    if (Test-Path '..\Day1_InitialBuilds' ) { Remove-Item '..\Day1_InitialBuilds' -Recurse  -Force }
    if (Test-Path '..\Day1_inspec' ) { Remove-Item '..\Day1_inspec' -Recurse  -Force }
    Copy-Item -Path "..\ZZBaseFiles\Day1Work\Day1_InitialBuilds"  -Recurse -Destination "..\" -Container 
    if (Test-Path '..\Day1_InitialBuilds\*_0.tf' ) { Remove-Item '..\Day1_InitialBuilds\*_0.tf' -Recurse  -Force }
    Copy-Item -Path "..\ZZBaseFiles\Day1Work\Day1_inspec"  -Recurse -Destination "..\" -Container 

    echo "`r`n---------------Codebase Ready For Modification ---------------"
    echo " Day1_InitialBuilds:  Initial server builds"
    echo " Day1_inspec folder:  Inspec tests "
    echo "--------------------------------------------------------------`r`n"
}
elseif ( $resetTF ) { 
    if (Test-Path '..\Day1_InitialBuilds\.terraform' ) { Remove-Item '..\Day1_InitialBuilds\.terraform' -Recurse  -Force } 
}
elseif ( $resetAll ) { 
    if (Test-Path '..\Day1_InitialBuilds' ) { Remove-Item '..\Day1_InitialBuilds' -Recurse  -Force } 
    if (Test-Path '..\Day1_Inspec' ) { Remove-Item '..\Day1_Inspec' -Recurse  -Force } 
}
else {
    echo "`r`n-------------------------------------------------------------------------------------" 
    echo "                                                   NO PARAMETER SPECIFIED" 
    echo "./Day0_InitialSetup.ps1 -day1     Setup all folder/files for the initial work"
    echo "./Day0_InitialSetup.ps1 -resetTF  Reset for a TF run (remove .terraform folder, etc)"
    echo "./Day0_InitialSetup.ps1 -resetAll Reset All, reset back to factory defaults"
    echo "-----------------------------------------------------------------------------------------`r`n" 
}