$Username = 'ms\arcsrvc' 
$Password = 'mom519ug!' 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
$Serversfile = Get-Content serversAPP.txt 
$SApp = Get-Content ServersApp.txt
$ServersRDT = Get-Content serversRDT.txt 
$ServersWeb = Get-Content serversWEB.txt


function Main{
    Clear-Host
    Invoke-Expression "& .\E:\SC\UCodeMaster.ps1 -Credential $Cred"
    }

Function Get-FileName($initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null

    $OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog2.initialDirectory = $initialDirectory
    $OpenFileDialog2.filter = "XML (XML)| *.xml"
    $OpenFileDialog2.ShowDialog() | Out-Null

}

$inputfile = Get-FileName "E:\"
$inputdata = get-content $inputfile

#Get-FileName($select)

function SUIDCopy{ 
# txt file suids.txt
# Destination E:\SC
}

function APPCopy{ 
# txt file serversAPP.txt
# Destination E:\SC
}

function RDTCopy{ 

# txt file serversRDT.txt
# Destination E:\SC
}

function WEBCopy{
# txt file serversWEB.txt
# Destination E:\SC 
}

function XMLAPPCopy{
 
# XML file POC_APP_SERVER_INSTALL.xml
# Destination $Serversfile = Get-Content serversAPP.txt 
}

function XMLRDTCopy{ 
# XML file POC_RDT_SERVER_INSTALL.xml
# Destination $Serversfile = Get-Content serversRDT.txt 
}

function XMLWEBCopy{ 
# XML file POC_W_SERVER_INSTALL.xml
# Destination $Serversfile = Get-Content serversWEB.txt 
}


function Start_Menu{ 

Write-Host '
*************************************************
*   Right Fax Install System - File Copy Menu   *
*************************************************
*   Type SUID to copy SUID list file to         *
*   local E:\SC\                                *
*                                               *  
*   Type APP to copy APP list file to           *
*   local E:\SC\                                *                                          
*                                               *   
*   Type RDT to copy RDT list file to           *
*   local E:\SC\                                *
*                                               * 
*   Type WEB to copy WEB list files to          *
*   local E:\SC\                                *  
*                                               * 
*   Type XMLAPP to copy APP XML file to         *
*   ONLY to APP Servers                         *                                          
*                                               *   
*   Type XMLRDT to copy RDT XML file to         *
*   ONLY to RDT Servers                         *
*                                               * 
*   Type XMLWEB to copy WEB XML files to        *
*   ONLY to WEB Servers                         *
*                                               *
*                                               *
*   Type MAIN to Return to Main Menu            *
*                                               *
*                                               *
*   Press X to Exit                             *
*************************************************
'
while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Install"
    Break
}

$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "SUID"){SUIDCopy($addorchange)}
if ($addorchange -like "APP"){APPCopy($addorchange)}
if ($addorchange -like "RDT"){RDTCopy($addorchange)}
if ($addorchange -like "WEB"){WEBCopy($addorchange)}
if ($addorchange -like "XMLAPP"){XMLAPPCopy($addorchange)}
if ($addorchange -like "XMLRDT"){XMLRDTCopy($addorchange)}
if ($addorchange -like "XMLWEB"){XMLWEBCopy($addorchange)}
if ($addorchange -like "MAIN"){MAIN($addorchange)}
} 
#End of StartFileCopy Function
Start_Menu ($select)