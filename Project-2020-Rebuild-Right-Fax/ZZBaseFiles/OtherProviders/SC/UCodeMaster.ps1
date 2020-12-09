#$RDTSandSUIDS = SCodeDistributeRDTSandSUIDS.ps1
#$Cleanup = SCodeCleanup.ps1
#$CopyFiles = SCodeCopyFiles.ps1
#$Install = SCodeInstall.ps1
#$PrepServers = SCodeCleanup.ps1

$Username = Read-Host -Prompt 'Input the user name'
$Password = Read-Host 'What is your password?' -AsSecureString
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 


function CopyFiles{ 

import-module E:\SC\SCodeCopyFiles.ps1
& "E:\SC\SCodeCopyFiles.ps1"
}

function RDTSandSUIDS{ 
import-module E:\SC\SCodeDistributeRDTSandSUIDS.ps1

& "E:\SC\SCodeDistributeRDTSandSUIDS.ps1"

}

function PrepServers{ 
import-module E:\SC\SCodePrepServers.ps1
& "E:\SC\SCodePrepServers.ps1"
}

function Installs{ 
import-module E:\SC\SCodeInstall.ps1
& "E:\SC\SCodeInstall.ps1"
}

function Cleanup{
import-module E:\SC\SCodeCleanup.ps1
. "E:\SC\SCodeCleanup.ps1"
}


function Start_Menu{
Write-Host '
*************************************************
*     Right Fax Install System - Main Menu      *
*************************************************
*   Type 1 to Setup Directories and copy        *
*   software on servers                         *
*                                               *
*   Type 2 To Setup RDT Board servers to Fax    *
*   Appilcation per Collective & SUIDS          *
*                                               *
*   Type 3 To Prep RightFax Software            *
*   on Servers                                  *
*                                               *
*   Type 4 To Install RightFax Software         *
*   on Servers                                  *
*                                               *
*   Type 5 to Clean Up Server Settings          *
*   on Servers                                  *
*                                               *
*   Press X to Exit or Enter to Continue        *
*************************************************'

while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Install"
    Break
}
$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "1"){CopyFiles($addorchange)}
if ($addorchange -like "2"){RDTSandSUIDS($addorchange)}
if ($addorchange -like "3"){PrepServers($addorchange)}
if ($addorchange -like "4"){Installs($addorchange)}
if ($addorchange -like "5"){Cleanup($addorchange)}


}

Start_Menu($select)

