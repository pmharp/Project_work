#$RDTSandSUIDS = SCodeDistributeRDTSandSUIDS.ps1
#$Cleanup = SCodeCleanup.ps1
#$CopyFiles = SCodeCopyFiles.ps1
#$Install = SCodeInstall.ps1
#$PrepServers = SCodeCleanup.ps1

$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 

function CopyFiles{
#Import-Module .\Optum.Powershell.Utility.EasyLog.psm1 -Verbose
Invoke-expression -Command .\SCodeCopyFiles.PS1
Start_Menu($select)
}

function RDTSandSUIDS{ 
    Invoke-expression -Command .\SCodeDistributeRDTSandSUIDS.ps1
}

function PrepServers{ 
    Invoke-expression -Command .\SCodePrepServers.ps1
}

function Installs{ 
    Invoke-expression -Command .\SCodeInstall.ps1
}

function Cleanup{
    Invoke-expression -Command .\SCodeCleanup.ps1
}

function End_System{
    Pause
    Exit   
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
$addorchange = Read-Host -Prompt 'Enter Choice'

while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Install"
    Exit    
}

if ($addorchange -like "1"){CopyFiles($addorchange)}
if ($addorchange -like "2"){RDTSandSUIDS($addorchange)}
if ($addorchange -like "3"){PrepServers($addorchange)}
if ($addorchange -like "4"){Installs($addorchange)}
if ($addorchange -like "5"){Cleanup($addorchange)}


}

Start_Menu($select)

    