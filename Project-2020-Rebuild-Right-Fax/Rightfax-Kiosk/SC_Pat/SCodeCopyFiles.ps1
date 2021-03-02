﻿$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 

$NewFolder1 = "RFTemp" 
$NewFolder2 = "MSMQ" 
$NewFolder3 = "Utils" 
$NewFolder4 = "XMLDumpster" 
$NewFolder5 = "Bad_EDC" 
$NewFolder6 = "Inetpub" 
$NewFolder7 = "Software"
$Holdrdpset = "" 
#file arrays
$Serversfile = Get-Content serversAPP.txt 
$SApp = Get-Content ServersApp.txt
$ServersRDT = Get-Content serversRDT.txt 
$ServersWeb = Get-Content serversWEB.txt
$ServersTYP = @($Serversfile), @($ServersRDT)
$ServersENT = @($Serversfile), @($ServersRDT), @($ServersWEB) 
$s = $Server 
$select = "" 
$s = $Server
$r = $Serverr
$w = $Serverw
$a = $Servera
$t = $Servert

#Command to create folder using variables.  

$command1 = { New-Item -Path E:\$Using:NewFolder1 -ItemType Directory } 
$command2 = { New-Item -Path E:\$Using:NewFolder2 -ItemType Directory } 
$command3 = { New-Item -Path E:\$Using:NewFolder3 -ItemType Directory } 
$command4 = { New-Item -Path E:\$Using:NewFolder4 -ItemType Directory } 
$command5 = { New-Item -Path E:\$Using:NewFolder5 -ItemType Directory } 
$command6 = { New-Item -Path E:\$Using:NewFolder6 -ItemType Directory } 
$command7 = { New-Item -Path E:\$Using:NewFolder7 -ItemType Directory } 

$SeedServer ="" 
$RDPSet = "" 




function Main{
Invoke-expression -Command ./UCodeMaster.ps1
}

function FILCopy{
Invoke-expression -Command ./SCodeSingleFileCopy.ps1
}  

function APPCopy{ 

foreach($Server in $ServersAPP){ 
  $s = $Server 


  Write-host -ForegroundColor Green "Begin File Copy Function" $S

Write-Host -ForegroundColor Green "Creating Directories for server" $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command1 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command2 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command3 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command4 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command5 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command6 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command7 

Write-Host -ForegroundColor Green "Directories Created" 

Write-Host -ForegroundColor Green "Copying RightFax Directory from Source Server to" $S "E:\Software" 

$SourcePath='\\apvest23418\e$\software\RightFax' 
$DestinationPath = "\\$s\e$\software\RightFax" 
 
$files = Get-ChildItem -Path $sourcePath -Recurse 

$filecount = $files.count 
$i=0 

Write-Host -ForegroundColor Green "Counting files Line" $S 

Foreach ($file in $files) { 
    $i++ 
    Write-Progress -activity "Moving files..." -status "($i of $filecount) $file" -percentcomplete (($i/$filecount)*100)    

    # Determine the absolute path of this object's parent container.  This is stored as a different attribute on file and folder objects so we use an if block to cater for both 

    if ($file.psiscontainer) {$sourcefilecontainer = $file.parent} else {$sourcefilecontainer = $file.directory} 

    # Calculate the path of the parent folder relative to the source folder 

    $relativepath = $sourcefilecontainer.fullname.SubString($sourcepath.length) 

    # Copy the object to the appropriate folder within the destination folder 

    copy-Item $file.fullname ($destinationPath + $relativepath)


   
} 
#End of PrepServer Function
} 
Start_Menu($select)
}



function RDTCopy{ 

foreach($entryRDT in $ServersRDT){ 
  $r = $entryRDT

Write-Host -ForegroundColor Green "Creating Directories for server" $r 

invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command1 
invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command2 
invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command3 
invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command4 
invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command5 
invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command6 
invoke-command -ComputerName $r -Credential $Cred -ScriptBlock $command7 

Write-Host -ForegroundColor Green "Directories Created" 

Write-Host -ForegroundColor Green "Copying RightFax Directory from Source Server to" $r "E:\Software" 

$SourcePath='\\apvest23418\e$\software\RightFax' 
$DestinationPath = "\\$r\e$\software\RightFax" 
 
$files = Get-ChildItem -Path $sourcePath -Recurse 

$filecount = $files.count 
$i=0 

Write-Host -ForegroundColor Green "Counting files Line" $r 

Foreach ($file in $files) { 
    $i++ 
    Write-Progress -activity "Moving files..." -status "($i of $filecount) $file" -percentcomplete (($i/$filecount)*100)    

    # Determine the absolute path of this object's parent container.  This is stored as a different attribute on file and folder objects so we use an if block to cater for both 

    if ($file.psiscontainer) {$sourcefilecontainer = $file.parent} else {$sourcefilecontainer = $file.directory} 

    # Calculate the path of the parent folder relative to the source folder 

    $relativepath = $sourcefilecontainer.fullname.SubString($sourcepath.length) 

    # Copy the object to the appropriate folder within the destination folder 

    copy-Item $file.fullname ($destinationPath + $relativepath) 
} 
#End of PrepServer Function
} 
Start_Menu($select)
}

function WEBCopy{ 

foreach($entryWEB in $ServersWEB){ 
  $w = $entryWEB 

Write-Host -ForegroundColor Green "Creating Directories for server" $W 

invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command1 
invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command2 
invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command3 
invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command4 
invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command5 
invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command6 
invoke-command -ComputerName $w -Credential $Cred -ScriptBlock $command7 

Write-Host -ForegroundColor Green "Directories Created" 

Write-Host -ForegroundColor Green "Copying RightFax Directory from Source Server to" $w "E:\Software" 

$SourcePath='\\apvest23418\e$\software\RightFax' 
$DestinationPath = "\\$w\e$\software\RightFax" 
 
$files = Get-ChildItem -Path $sourcePath -Recurse 

$filecount = $files.count 
$i=0 

Write-Host -ForegroundColor Green "Counting files Line" $w 

Foreach ($file in $files) { 
    $i++ 
    Write-Progress -activity "Moving files..." -status "($i of $filecount) $file" -percentcomplete (($i/$filecount)*100)    

    # Determine the absolute path of this object's parent container.  This is stored as a different attribute on file and folder objects so we use an if block to cater for both 

    if ($file.psiscontainer) {$sourcefilecontainer = $file.parent} else {$sourcefilecontainer = $file.directory} 

    # Calculate the path of the parent folder relative to the source folder 

    $relativepath = $sourcefilecontainer.fullname.SubString($sourcepath.length) 

    # Copy the object to the appropriate folder within the destination folder 

    copy-Item $file.fullname ($destinationPath + $relativepath) 
} 
#End of PrepServer Function
} 
Start_Menu($select)
}


function TYPCopy{ 
foreach($entryTYP in $ServersTYP){ 
  $t = $entryTYP 

   
Write-Host -ForegroundColor Green "Creating Directories for server" $entryTYP
Write-Host -ForegroundColor Green "Creating Directories for server" $ServersTYP
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command1 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command2 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command3 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command4 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command5 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command6 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command7 

Write-Host -ForegroundColor Green "Directories Created" 

Write-Host -ForegroundColor Green "Copying RightFax Directory from Source Server to" $a "E:\Software" 

$SourcePath='\\apvest23418\e$\software\RightFax' 
$DestinationPath = "\\$a\e$\software\RightFax" 
 
$files = Get-ChildItem -Path $sourcePath -Recurse 

$filecount = $files.count 
$i=0 

Write-Host -ForegroundColor Green "Counting files Line" $a 

Foreach ($file in $files) { 
    $i++ 
    Write-Progress -activity "Moving files..." -status "($i of $filecount) $file" -percentcomplete (($i/$filecount)*100)    

    # Determine the absolute path of this object's parent container.  This is stored as a different attribute on file and folder objects so we use an if block to cater for both 

    if ($file.psiscontainer) {$sourcefilecontainer = $file.parent} else {$sourcefilecontainer = $file.directory} 

    # Calculate the path of the parent folder relative to the source folder 

    $relativepath = $sourcefilecontainer.fullname.SubString($sourcepath.length) 

    # Copy the object to the appropriate folder within the destination folder 

    copy-Item $file.fullname ($destinationPath + $relativepath) 
} 
#End of PrepServer Function
}
Start_Menu($select)
}

function ENTIRECopy{ 
foreach($entryENT in $ServersALL){ 
  $a = $entryENT 

   
Write-Host -ForegroundColor Green "Creating Directories for server" $entryENT
Write-Host -ForegroundColor Green "Creating Directories for server" $ServersALL
PAUSE

invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command1 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command2 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command3 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command4 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command5 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command6 
invoke-command -ComputerName $a -Credential $Cred -ScriptBlock $command7 

Write-Host -ForegroundColor Green "Directories Created" 

Write-Host -ForegroundColor Green "Copying RightFax Directory from Source Server to" $a "E:\Software" 

$SourcePath='\\apvest23418\e$\software\RightFax' 
$DestinationPath = "\\$a\e$\software\RightFax" 
 
$files = Get-ChildItem -Path $sourcePath -Recurse 

$filecount = $files.count 
$i=0 

Write-Host -ForegroundColor Green "Counting files Line" $a 

Foreach ($file in $files) { 
    $i++ 
    Write-Progress -activity "Moving files..." -status "($i of $filecount) $file" -percentcomplete (($i/$filecount)*100)    

    # Determine the absolute path of this object's parent container.  This is stored as a different attribute on file and folder objects so we use an if block to cater for both 

    if ($file.psiscontainer) {$sourcefilecontainer = $file.parent} else {$sourcefilecontainer = $file.directory} 

    # Calculate the path of the parent folder relative to the source folder 

    $relativepath = $sourcefilecontainer.fullname.SubString($sourcepath.length) 

    # Copy the object to the appropriate folder within the destination folder 

    copy-Item $file.fullname ($destinationPath + $relativepath) 
} 
#End of PrepServer Function
}
Start_Menu($select)
}



function Start_Menu{ 

Write-Host '
*************************************************
*   Right Fax Install System - File Copy Menu   *
*************************************************
*   Type APP to copy install files to           *
*   APP ONLY Servers                            *
*                                               *  
*   Type TYP to copy install files to           *
*   APP & RDT Servers                           *                                          
*                                               *   
*   Type RDT to copy install files to           *
*   RDT ONLY Servers                            *
*                                               * 
*   Type WEB to copy install files to           *
*   WEB ONLY Servers                            *  
*                                               * 
*   Type ENT to copy install files to ALL       *
*   Servers                                     *
*                                               *
*   Type FIL to copy single files               *
*    ** ONLY after copying intial files **      *
*                                               *
*   Type MAIN to Return to main Menu            *
*                                               *
*                                               *
*   Press X to Exit or Enter to Continue        *
*************************************************
'
while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Install"
    Break
}

$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "ENT"){ENTIRECopy($addorchange)}
if ($addorchange -like "APP"){APPCopy($addorchange)}
if ($addorchange -like "TYP"){TYPCopy($addorchange)}
if ($addorchange -like "RDT"){RDTCopy($addorchange)}
if ($addorchange -like "WEB"){WEBCopy($addorchange)}
if ($addorchange -like "FIL"){FILCopy($addorchange)}
if ($addorchange -like "MAIN"){MAIN($addorchange)}
} 
#End of StartFileCopy Function
Start_Menu ($select)