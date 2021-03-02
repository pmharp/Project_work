$Userid = Read-Host "Enter Your Primary ID"
$ServersAPP  = Get-Content serversAPP.txt 
$ServersRDT  = Get-Content serversRDT.txt 
$ServersWeb  = Get-Content serversWEB.txt

$initialDirectory = "\\apvest23418\E$\Software\Extra"

function Main{
 Invoke-Expression "& .\UCodeMaster.ps1 -Credential $Cred"
}

Function Get-FileText($initialDirectory){
#    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
    $src = $OpenFileDialog.FileName
}

Function Get-FileXML($initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog2.initialDirectory = $initialDirectory
    $OpenFileDialog2.filter = "XML (XML)| *.xml"
    $OpenFileDialog2.ShowDialog() | Out-Null


}

#$inputfile = Get-FileName "E:\"
#$inputdata = get-content $inputfile

#Get-FileName($select)

function SUIDCopy{ 
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
    $src = $OpenFileDialog.FileName
    $dest = "E:\sc\"
    Copy-Item $src $dest
Start-Menu($select)
}

function APPCopy{ 
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
    $src = $OpenFileDialog.FileName
    $dest = "E:\sc\"
    Copy-Item $src $dest
Start-Menu($select)
}

function RDTCopy{ 

    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
    $src = $OpenFileDialog.FileName
    $dest = "E:\sc\"
    Copy-Item $src $dest
Start-Menu($select)
}

function WEBCopy{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.FileName
    $src = $OpenFileDialog.FileName
    $dest = "E:\sc\"      
    Copy-Item $src $dest
Start-Menu($select)
}

function XMLAPPCopy{
    Write-Host "Select the version of Serverapp.txt"
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog1 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog1.initialDirectory = $initialDirectory
    $OpenFileDialog1.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog1.ShowDialog() | Out-Null
    $OpenFileDialog1.FileName
    $src1 = $OpenFileDialog1.FileName
    $Files = gc $src1
    Write-Host "Select the version of POC_APP_Servers_Install.xml"
    $OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog2.initialDirectory = $initialDirectory
    $OpenFileDialog2.filter = "XML (XML)| *.xml"
    $OpenFileDialog2.ShowDialog() | Out-Null
    $OpenFileDialog2.FileName
    $src2 = $OpenFileDialog2.FileName
    $dest2 = "E:\sc\"
    
    Foreach ($File in $Files) {
     Write-Host "File" $File
     Write-Host "Source File" $src2
     invoke-command -ComputerName $File -ScriptBlock { 
        Copy-Item $src2 $dest2
     }
    }
Start-Menu($select)
}

function XMLRDTCopy{ 
    Write-Host "Select the version of Serverrdt.txt"
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog1 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog1.initialDirectory = $initialDirectory
    $OpenFileDialog1.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog1.ShowDialog() | Out-Null
    $OpenFileDialog1.FileName
    $src1 = $OpenFileDialog1.FileName
    $Files = gc $src1
    Write-Host "Select the version of POC_RDT_Servers_Install.xml"
    $OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog2.initialDirectory = $initialDirectory
    $OpenFileDialog2.filter = "XML (XML)| *.xml"
    $OpenFileDialog2.ShowDialog() | Out-Null
    $OpenFileDialog2.FileName
    $src2 = $OpenFileDialog2.FileName
    $dest2 = "E:\sc\"
    
    Foreach ($File in $Files) {
     Write-Host "File" $File
     Write-Host "Source File" $src2
     invoke-command -ComputerName $File -ScriptBlock { 
        Copy-Item $src2 $dest2
     }
    }
}

function XMLWEBCopy{ 
    Write-Host "Select the version of Serverrdt.txt"
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog1 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog1.initialDirectory = $initialDirectory
    $OpenFileDialog1.filter = "TXT (TXT)| *.txt"
    $OpenFileDialog1.ShowDialog() | Out-Null
    $OpenFileDialog1.FileName
    $src1 = $OpenFileDialog1.FileName
    $Files = gc $src1
    Write-Host "Select the version of POC_RDT_Servers_Install.xml"
    $OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog2.initialDirectory = $initialDirectory
    $OpenFileDialog2.filter = "XML (XML)| *.xml"
    $OpenFileDialog2.ShowDialog() | Out-Null
    $OpenFileDialog2.FileName
    $src2 = $OpenFileDialog2.FileName
    $dest2 = "E:\sc\"
    
    Foreach ($File in $Files) {
     Write-Host "File" $File
     Write-Host "Source File" $src2
     invoke-command -ComputerName $File -ScriptBlock { 
        Copy-Item $src2 $dest2
     }
    }
}

function Start-Menu{ 

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
*   Press X to Exit or Enter to Continue        *
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
Start-Menu ($select)