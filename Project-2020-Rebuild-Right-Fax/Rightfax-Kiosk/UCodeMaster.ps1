#$RDTSandSUIDS = SCodeDistributeRDTSandSUIDS.ps1
#$Cleanup = SCodeCleanup.ps1
#$CopyFiles = SCodeCopyFiles.ps1
#$Install = SCodeInstall.ps1
#$PrepServers = SCodeCleanup.ps1

function CopyFiles{ 
    clear-host
    Invoke-expression "& .\SCodeCopyFiles.ps1 -Credential $Cred -Argument $argumentList"
    Start_Menu($select)
}

function RDTSandSUIDS{ 
    clear-host
    Invoke-expression "& .\SCodeDistributeRDTSandSUIDS.ps1 -Credential $Cred -Argument $argumentList"
    Start_Menu($select)
}

function PrepServers{ 
    clear-host
    Invoke-expression "& .\SCodePrepServers.ps1 -Credential $Cred -Argument $argumentList"
    Start_Menu($select)
}

function Installs{ 
    clear-host
    Invoke-expression "& .\SCodeInstall.ps1 -Credential $Cred -Argument $argumentList"
    Start_Menu($select)
}

function Cleanup{
    clear-host
    Invoke-expression "& .\SCodeCleanup.ps1 -Credential $Cred -Argument $argumentList"
    Start_Menu($select)
}

function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}


function Start_Menu{
Write-Host '
*************************************************
*     Right Fax Install System - Main Menu      *
*************************************************
*   Type 1 to Setup Directories and copy        *
*   software on servers                         *
*                                               *
*   Type 2 To Prep RightFax Software            *
*   on Servers                                  *
*                                               *
*   Type 3 To Setup RDT Board servers to Fax    *
*   Appilcation per Collective & SUIDS          *
*                                               *
*   Type 4 To Install RightFax Software         *
*   on Servers                                  *
*                                               *
*   Type 5 to Clean Up Server Settings          *
*   on Servers                                  *
*                                               *
*   Type MAIN to Return to main Menu            *
*                                               *
*   Press X to Exit                             *
*************************************************'


$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "1"){CopyFiles($addorchange)}
if ($addorchange -like "2"){PrepServers($addorchange)}
if ($addorchange -like "3"){RDTSandSUIDS($addorchange)}
if ($addorchange -like "4"){Installs($addorchange)}
if ($addorchange -like "5"){Cleanup($addorchange)}
if ($addorchange -like "Main"){Master_Menu($addorchange)}
if ($addorchange -like "x"){BYEING($addorchange)}

}



Function BYEING{ 

Write-Host "Exiting Right Fax System Install"
    Break

}

Start_Menu($select)
