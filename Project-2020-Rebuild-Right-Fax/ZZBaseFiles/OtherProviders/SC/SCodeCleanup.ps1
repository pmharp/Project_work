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
$r = $Serverr
$w = $Serverw
$a = $Servera
$t = $Servert


function Start_Menu{ 

Write-Host '
*************************************************
*   Right Fax Clean System - Clean Up Menu     *
*************************************************
*   Type APP to Clean Up                        *
*   APP ONLY Servers                            *
*                                               *  
*   Type TYP to Clean Up                        *
*   APP & RDT Servers                           *                                          
*                                               *   
*   Type RDT to Clean Up                        *
*   RDT ONLY Servers                            *
*                                               * 
*   Type WEB to Clean Up                        *
*   WEB ONLY Servers                            *  
*                                               * 
*   Type ENT to Clean Up                        *
*   ALL Servers                                 *
*                                               *
*   Type MAIN to Return to main Menu            *
*                                               *
*   Press X to Exit or Enter to Continue        *
*************************************************
'
while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Clean Up"
    Break
}

$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "ENT"){ENTClean($addorchange)}
if ($addorchange -like "APP"){APPClean($addorchange)}
if ($addorchange -like "TYP"){TYPClean($addorchange)}
if ($addorchange -like "RDT"){RDTClean($addorchange)}
if ($addorchange -like "WEB"){WEBClean($addorchange)}

}   





function APPClean{ 

foreach($Server in $Serversfile){ 
  $s = $Server 
  Write-Host -ForegroundColor Red "Starting Function Cleanup"

Write-Host -ForegroundColor Green "Adding Registry Keys back  Line 357 " $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
  Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext' -value 'Legal Notice' 
  Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption' -value 'This is a private computer system containing confidential information. Any unauthorized attempt to access or use this computer system or any information on it by employees or other persons may result in termination of employment, civil fines, and criminal penalties. This system must be used for authorized business purposes only.' 
  Write-Host -ForegroundColor Green "Initiating Cleanup  Line 386" $S  

# delete  scheduled task for Optume_installer.bat 

  Write-Host -ForegroundColor Green "... security prompt   Line 357 " $S 
  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '1' 

  Write-Host -ForegroundColor Green "Deleting Optum_installers  Line 391" $S  

  Unregister-ScheduledTask -TaskName "Optum_installer" -Confirm:$false
    Unregister-ScheduledTask -TaskName "Optum_installerAPP" -Confirm:$false 
      Unregister-ScheduledTask -TaskName "Optum_installerRDT" -Confirm:$false
        Unregister-ScheduledTask -TaskName "Optum_installerWEB" -Confirm:$false   

  Write-Host -ForegroundColor Green "Re-enabling Chef- Client and Chef-Client on Restart  Line 396" $S  

  Enable-ScheduledTask -TaskName "chef-client"; Enable-ScheduledTask -TaskName "chef-client on restart" 

  } 
   
} 
#End of PrepServer Function
} 
Start_Menu($select)




function RDTClean{ 

foreach($entryRDT in $ServersRDT){ 
  $r = $entryRDT
  $s = $r

  Write-Host -ForegroundColor Red "Starting Function Cleanup"

Write-Host -ForegroundColor Green "Adding Registry Keys back  Line 357 " $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
  Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext' -value 'Legal Notice' 
  Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption' -value 'This is a private computer system containing confidential information. Any unauthorized attempt to access or use this computer system or any information on it by employees or other persons may result in termination of employment, civil fines, and criminal penalties. This system must be used for authorized business purposes only.' 
  Write-Host -ForegroundColor Green "Initiating Cleanup  Line 386" $S  

# delete  scheduled task for Optume_installer.bat 

  Write-Host -ForegroundColor Green "... security prompt   Line 357 " $S 
  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '1' 

  Write-Host -ForegroundColor Green "Deleting Optum_installer  Line 391" $S  

   Unregister-ScheduledTask -TaskName "Optum_installer" -Confirm:$false
    Unregister-ScheduledTask -TaskName "Optum_installerAPP" -Confirm:$false 
      Unregister-ScheduledTask -TaskName "Optum_installerRDT" -Confirm:$false
        Unregister-ScheduledTask -TaskName "Optum_installerWEB" -Confirm:$false   


  Write-Host -ForegroundColor Green "Re-enabling Chef- Client and Chef-Client on Restart  Line 396" $S  

  Enable-ScheduledTask -TaskName "chef-client"; Enable-ScheduledTask -TaskName "chef-client on restart" 

  } 

} 
#End of PrepServer Function
} 
Start_Menu($select)


function WEBClean{ 

foreach($entryWEB in $ServersWEB){ 
  $w = $entryWEB 
  $s = $w


  Write-Host -ForegroundColor Red "Starting Function Cleanup"

Write-Host -ForegroundColor Green "Adding Registry Keys back  Line 357 " $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
  Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext' -value 'Legal Notice' 
  Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption' -value 'This is a private computer system containing confidential information. Any unauthorized attempt to access or use this computer system or any information on it by employees or other persons may result in termination of employment, civil fines, and criminal penalties. This system must be used for authorized business purposes only.' 
  Write-Host -ForegroundColor Green "Initiating Cleanup  Line 386" $S  

# delete  scheduled task for Optume_installer.bat 

  Write-Host -ForegroundColor Green "... security prompt   Line 357 " $S 
  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '1' 

  Write-Host -ForegroundColor Green "Deleting Optum_installer  Line 391" $S  


 Unregister-ScheduledTask -TaskName "Optum_installer" -Confirm:$false
    Unregister-ScheduledTask -TaskName "Optum_installerAPP" -Confirm:$false 
      Unregister-ScheduledTask -TaskName "Optum_installerRDT" -Confirm:$false
        Unregister-ScheduledTask -TaskName "Optum_installerWEB" -Confirm:$false   

  Write-Host -ForegroundColor Green "Re-enabling Chef- Client and Chef-Client on Restart  Line 396" $S  

  Enable-ScheduledTask -TaskName "chef-client"; Enable-ScheduledTask -TaskName "chef-client on restart" 

  } 




} 
#End of PrepServer Function
}
Start_Menu($select)


function ENTIREClean{ 
foreach($entryENT in $ServersALL){ 
  $a = $entryENT
  $s = $a 







} 
#End of PrepServer Function
}
Start_Menu($select)


 