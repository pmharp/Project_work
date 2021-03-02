$SeedServer ="" 
$RDPSet = "" 
$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
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




function BYEING{ 

Write-Host "Exiting Right Fax System prep" 
Break


}





Function Copy_Check{
Write-Host '
*************************************************
*     Right Fax Installation - Copy Check       *
*************************************************
*   Have installation files been copied         *
*    to the destination servers?                *
*   Type Copy to Copy Files Now or              *
*   Type Next to Continue                       *
*************************************************'
while( $addorchange -like "x"){
    Write-Host "Exiting to the Copy Menu"
    BREAK
}

$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "Copy"){Start_FileCopy($addorchange)}
if ($addorchange -like "Next"){Start_Collect($addorchange)}

}

Function DisplayRDTtoServer{
 

$vms = Get-Content serversAPP.txt 
$hosts = Get-Content serversRDT.txt 
$array = @($vms), @($hosts) 

Write-Host -ForegroundColor Cyan "Total list of Servers 

  

  

"  

Write-Host -ForegroundColor Cyan "Seed Server"  

$SeedServer    # 1

Write-Host -ForegroundColor Green "App Servers"  

$array[0]    # 1 

Write-Host -ForegroundColor Blue "RDT Servers"  

$array[1]    # 2 

while( $addorchange -notlike "x"){  

$addorchange = Read-Host -Prompt '  

If these Servers are correct, type yes 

To Quit and Edit Server list press X  

'  

if ($addorchange -like "yes"){ReadRDTXML($addorchange) Write-Host "Going to Read RDT XML"} 
  while( $addorchange -notlike "x"){  
  $addorchange = Read-Host -Prompt '
  
  To Write these RDT settings, type write  

  To Quit press X  

'  
  Write-Host $Serversfile[1]  

  Write-Host $Serversfile[2]  

  Write-Host 'Seed Server'  

  $SeedServer 

  if ($addorchange -like "write"){WriteRDTXML($select)} 

#End of the While Loop Like
}  
 
#End of the While Loop Not Like
} 
 
# End of DisplayRDTtoServer Function
} 
Function ReadRDTXML{ 

#$RDPSet = Read-Host -Prompt 'How many RDP Tags per App Server' 

$ServersApp = Get-Content serversapp2.txt  
$ServersRDP = Get-Content serversRDT.txt 
#$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $MSID,$MSPass  
$RDPCount = 1 
$select = "" 
$holdApp =0 
$holdRDP = 0 
$linecount = $serversapp.count 

Write-Host -ForegroundColor Green "Starting the Interface Process" 

  

function ReadApp{


         $SA = $ServersApp[$holdapp] 

         If ($holdapp -eq $Linecount) 
            
            {Write-Host -ForegroundColor Red "APP Sets have been completed" 
             Return} 

         else{  

         SetRDP($select)    

         } 

}         

function SetRDP{ 
     
    If ($RDPCount -gt $RDPSet){ 

        $RDPCount = 1 

        Write-host "Tags are set for App Server " $SA 

        $holdapp ++ 

        BreakRDPGT($select) 

    } 

    else{ 

    $SR = $ServersRDP[$holdrdp] 

    $RDPCount ++ 

    $holdrdp ++ 

    Write-Host "RDT servers " $SR 

    SetRDP($select)     

    }   

} 

function BreakRDPGT{ 

    ReadApp($select) 

} 

ReadApp($select) 

  
#End of ReadRDTXML Function
} 

  

Function WriteRDTXML{ 
 
$RDPSet2 = $RDPSet  
$SuidLic = Get-Content Suids.txt  
$ServersRDP2 = Get-Content serversRDT.txt
$ServersApp2 = Get-Content serversapp2.txt
$RDPCount2 = 1 
$select2 = "" 
$holdApp2 = 0
$holdrdp2 = 0
$Suidset = 0 
$linecount2 = $ServersApp2.count 
$SA2 = ""
  
$SA2 = $ServersApp2[$holdapp2]
If ($holdapp2 -eq $Linecount2) 
  {Write-Host -ForegroundColor Red "APP Sets have been completed" $RDPSet
  Return} 
else{ 
  Write-Host -ForegroundColor Red "RDPSet " 
  SetRDP2($select2)    
}

}
         
Function SetRDP2{

If ($RDPCount2 -gt $RDPSet){ 
  $RDPCount2 = 1
  #$holdserver = $holdApp2[1]
  $SUID = $SUIDLIC[$SUIDSet] 

  Write-Host -ForegroundColor Green " Writing SUID "$SUID" License to APP Server" $SA2 
  [xml]$myXML = Get-Content -Path "\\$SA2\e$\Software\RightFax\POC_APP_SERVER_INSTALL.xml" 
  $myXML.CommonInstallSettings.SUID = "$SUID" 
  $myXML.Save("\\$SA2\e$\Software\RightFax\POC_APP_SERVER_INSTALL.xml")  
  Write-host "Tags are set for App Server " $SA2 
  $holdapp2 ++
  $SuidSet ++ 
  ReadApp2($select2) 
} 
else{ 
  
  $SR2 = $ServersRDP2[$holdrdp2] 
  $RDPCount2 ++ 
  Write-Host -ForegroundColor Green " Writing Server name to RDT Server on" $SR2 "to" $SA2 
  [xml]$myXML = Get-Content -Path "\\$SR2\e$\Software\RightFax\POC_RDT_SERVER_INSTALL.xml" 
  $myXML.CommonInstallSettings.RightFaxServerName = "$SA2" 
  $myXML.Save("\\$SR2\e$\Software\RightFax\POC_RDT_SERVER_INSTALL.xml") 
  $holdrdp2 ++ 
  Write-Host "RDT servers " $SR2 
  SetRDP2($select2)     
}   
#End of SetRDBP2 Function
} 

#ReadApp2($select2) 

function ReadApp2{
         $SA2 = $ServersApp2[$holdapp2]
         If ($holdapp2 -eq $Linecount2) 
            
            {Write-Host -ForegroundColor Red "APP Sets have been completed" 
             Return} 

         else{  

         SetRDP2($select)    

         } 

          Write-Host "Exiting to the RDT / APP Associtation Menu"
Main ($select)
}#End of WriteRDTXML Function


function Main{
import-module E:\SC\UCodeMaster.ps1
& E:\SC\UCodeMaster.ps1
}
         



Function Start_Seed{
Write-Host '
*************************************************
*  Right Fax Install System - Set Seed Server   *
*************************************************
*   Type in the name of your Seed Server        *
*                                               *
*************************************************'

$SeedServer = Read-Host -Prompt 'Enter Seed Server'
$RDPSet = Read-Host -Prompt 'RDP'  
$APPHold = Get-Content serversAPP2.txt
$RDPHold = Get-Content serversRDT.txt
$LineAPP = $APPHold.count
$LineRDP = $RDPHold.count
$LineAns = $LineRDP / $RDPSET
'If ($lineAns -ne $LineApp){
  Write-Host "There is a mis match between RDT and APP servers"
  Write-Host "RDT Server Count: " $LineRDP
  Write-Host " App Server Count: " $LineApp
  Start_Seed($select)
}'


Write-Host 'Seed Server Set as:' $SeedServer 
Write-Host 'Wrting new serverapps file to include Seed Server:'  
$content = Get-Content serversAPP.txt 

#Create a new array 

$Output = @() 

#Add new text 

$Output += $SeedServer 

#Append old text from content 

$Output += $content 
$Output | Out-file serversAPP2.txt 
$newcontent = Get-Content serversAPP2.txt 

Write-Host "headin to rdt stuff " $addorchange
DisplayRDTtoServer($select) 

#End of the While Not Like Loop 
}
 
Start_Seed($select)

