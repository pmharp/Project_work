$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 

$SeedServer ="" 
$RDPSet = "" 
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

   


function APPinstall{ 

  Set-AutoLogonAPP
  ServerLogOnAPP
  ServerInstallAPP
  Start_InstallMenu($select) 
} 
#End of installServer Function



function TYPInstall{ 
 

  Set-AutoLogonAPP
  ServerLogOnAPP
  ServerInstallAPP

  Set-AutoLogonRDT
  ServerLogOnRDT
  ServerInstallRDT
  Start_InstallMenu($select) 
} 
#End of installServer Function 



function RDTinstall{ 

 
  Set-AutoLogonRDT
  ServerLogOnRDT
  ServerInstallRDT
  Start_InstallMenu($select)

} 
#End of installServer Function



function WEBinstall{   
  Set-AutoLogonWEB
  ServerLogOnWEB
  ServerInstallWeb
  Start_InstallMenu($select)
} 
#End of installServer Function


function ENTInstall{ 

  Set-AutoLogonAPP
  ServerLogOnAPP
  ServerInstallAPP

  Set-AutoLogonRDT
  ServerLogOnRDT
  ServerInstallRDT

  Set-AutoLogonWEB
  ServerLogOnWEB
  ServerInstallWEB
  Start_InstallMenu($select)
} 
#End of installServer Function

function Main{
  Invoke-expression -Command .\UCodeMaster.ps1
}

Function Set-AutoLogonAPP{

$Serversfile = Get-Content serversAPP.txt 

foreach($Server in $Serversfile){ 
  $s = $Server 

Write-Host -ForegroundColor Red "Starting Function Set-AutoLogon"

Write-Host -ForegroundColor Green "REG add "Autologon"  Line 27 " $S 

  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

invoke-command -ComputerName $server -Credential $Cred -ScriptBlock { 
   $s = $Server 
 

#Registry path declaration 

  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 
  $RegROPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" 

#setting registry values 

  Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1"  
  Set-ItemProperty $RegPath "DefaultUsername" -Value "$Username"  
  Set-ItemProperty $RegPath "DefaultPassword" -Value "$Password"  
  Set-ItemProperty $RegROPath "AutoAdminLogon" -Value "1"  
  Set-ItemProperty $RegROPath "DefaultUsername" -Value "$Username"  
  Set-ItemProperty $RegROPath "DefaultPassword" -Value "$Password"  
  Remove-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext'  
  Remove-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption'  
} 
#End of Set-AutoLogon Function
} 
}

Function Set-AutoLogonRDT{

$ServersRDT = Get-Content serversRDT.txt 

foreach($entryRDT in $ServersRDT){ 
$Server = $entryRDT
$s = $Server 

  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Write-Host -ForegroundColor Red "Starting Function Set-AutoLogon"

Write-Host -ForegroundColor Green "REG add "Autologon"  Line 27 " $S 

invoke-command -ComputerName $server -Credential $Cred -ScriptBlock { 

   $s = $Server 
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 

#Registry path declaration 

  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 
  $RegROPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" 

#setting registry values 

  Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1"  
  Set-ItemProperty $RegPath "DefaultUsername" -Value "$Username"  
  Set-ItemProperty $RegPath "DefaultPassword" -Value "$Password"  
  Set-ItemProperty $RegROPath "AutoAdminLogon" -Value "1"  
  Set-ItemProperty $RegROPath "DefaultUsername" -Value "$Username"  
  Set-ItemProperty $RegROPath "DefaultPassword" -Value "$Password"  
  Remove-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext'  
  Remove-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption'  
} 
#End of Set-AutoLogonRDT Function
} 
}

Function Set-AutoLogonWEB{

$ServersWeb = Get-Content serversWEB.txt

foreach($entryWEB in $ServersWEB){

$Server = $entryWEB
$s = $Server 
$w = $s
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Write-Host -ForegroundColor Red "Starting Function Set-AutoLogon"

Write-Host -ForegroundColor Green "REG add "Autologon"  Line 27 " $S 

invoke-command -ComputerName $server -Credential $Cred -ScriptBlock { 
   $s = $Server 
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 

#Registry path declaration 

  $RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" 
  $RegROPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" 

#setting registry values 

  Set-ItemProperty $RegPath "AutoAdminLogon" -Value "1"  
  Set-ItemProperty $RegPath "DefaultUsername" -Value "$Username"  
  Set-ItemProperty $RegPath "DefaultPassword" -Value "$Password"  
  Set-ItemProperty $RegROPath "AutoAdminLogon" -Value "1"  
  Set-ItemProperty $RegROPath "DefaultUsername" -Value "$Username"  
  Set-ItemProperty $RegROPath "DefaultPassword" -Value "$Password"  
  Remove-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext'  
  Remove-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption'  
} 
#End of Set-AutoLogonWEB Function
}

function ServerLogOnApp48{
Write-Host -ForegroundColor Red "Starting Function ServerLogon" 
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$a = $Server
# remote to machine 

Write-Host -ForegroundColor Green "Logging on To Server Line 351" $a    
start-sleep -Seconds 5 
cmdkey /generic:TERMSRV/$a /user:$Username /pass:$Password 
mstsc /v:$a 
Add-Type -AssemblyName System.Windows.Forms 
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
start-sleep -Seconds 20
#End of ServerLogOn Function
}
}

Function ServerLogOnAPP{

$Serversfile = Get-Content serversAPP.txt 

foreach($ServerAPP in $Serversfile){ 

$Server = $ServerAPP
$s = $Server
$a = $Server

Write-Host -ForegroundColor Red "Starting Function ServerLogon" 
$a = $Server
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
# remote to machine 

Write-Host -ForegroundColor Green "Logging on To Server Line 351" $a  
start-sleep -Seconds 5 
cmdkey /generic:TERMSRV/$a /user:$Username /pass:$Password 
mstsc /v:$a 
Add-Type -AssemblyName System.Windows.Forms 
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
start-sleep -Seconds 20
#End of ServerLogOn Function
}
}

function ServerLogOnRDT{

$ServersRDT = Get-Content serversRDT.txt 

foreach($entryRDT in $ServersRDT){ 
$Server = $entryRDT
$s = $Server
$r = $Server

Write-Host -ForegroundColor Red "Starting Function ServerLogon" 
$r = $Server
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
# remote to machine 

Write-Host -ForegroundColor Green "Logging on To Server Line 351" $rr   
start-sleep -Seconds 5 
cmdkey /generic:TERMSRV/$r /user:$Username /pass:$Password 
mstsc /v:$r 
Add-Type -AssemblyName System.Windows.Forms 
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
start-sleep -Seconds 20
#End of ServerLogOn Function
}
}

function ServerLogOnWEB{

$ServersWeb = Get-Content serversWEB.txt

foreach($entryWEB in $ServersWEB){

$Server = $entryWEB
$s = $Server 

$w = $Server

Write-Host -ForegroundColor Red "Starting Function ServerLogon" 

# remote to machine 
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Write-Host -ForegroundColor Green "Logging on To Server Line 351" $w    
start-sleep -Seconds 5 
cmdkey /generic:TERMSRV/$w /user:$Username /pass:$Password 
mstsc /v:$w
Add-Type -AssemblyName System.Windows.Forms 
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
start-sleep -Seconds 20
#End of ServerLogOn Function
}
}

function ServerInstallAPP{
$Serversfile = Get-Content serversAPP.txt 

foreach($Server in $Serversfile){ 
  $s = $Server 
  $a = $Server
    $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
$a = $Server
 Write-Host -ForegroundColor Green "installing Optum_installer  Line 372" $a

Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installer.xml' | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force 
start-sleep -Seconds 10

  Write-Host -ForegroundColor Green "Running Optum_installer App  Line 375" $a 
 Start-ScheduledTask -TaskName "Optum_installer" -TaskPath "RightFax"
}
}
}

function ServerInstallRDT{

$ServersRDT = Get-Content serversRDT.txt 

foreach($entryRDT in $ServersRDT){ 
$Server = $entryRDT
$s = $Server
$r = $Server
$r = $Server

  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
$r = $Server
 Write-Host -ForegroundColor Green "Installing Optum_installer  Line 372" $r

Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installerRDT.xml' | out-string) -TaskName "Optum_installerRDT" -TaskPath "RightFax" -Force 
start-sleep -Seconds 10

  Write-Host -ForegroundColor Green "Running Optum_installerRDT  Line 375" $r 
 Start-ScheduledTask -TaskName "Optum_installerRDT" -TaskPath "RightFax"

}
}
}

function ServerInstallWEB{

$ServersWeb = Get-Content serversWEB.txt

foreach($entryWEB in $ServersWEB){

$Server = $entryWEB
$s = $Server 
$w = $s
$w = $Server
  $Username = 'ms\arcnonprd' 
  $Password = 'mom519ug!' 

#$Serversfile = Get-Content serversAPP.txt 

  $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
  $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
$w = $Server
Write-Host -ForegroundColor Green "Installing Optum_installer  Line 372" $w 

Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installerWEB.xml' | out-string) -TaskName "Optum_installerWEB" -TaskPath "RightFax" -Force 
start-sleep -Seconds 10

Write-Host -ForegroundColor Green "Running Optum_installerWeB  Line 375" $w 
Start-ScheduledTask -TaskName "Optum_installerWEB" -TaskPath "RightFax"
}
}
}

function Start_InstallMenu{ 

  Write-Host '
  *************************************************
  *   Right Fax Install System - Install Menu     *
  *************************************************
  *   Type APP to install                         *
  *   APP ONLY Servers                            *
  *                                               *  
  *   Type TYP to install                         *
  *   APP & RDT Servers                           *                                          
  *                                               *   
  *   Type RDT to install                         *
  *   RDT ONLY Servers                            *
  *                                               * 
  *   Type WEB to install                         *
  *   WEB ONLY Servers                            *  
  *                                               * 
  *   Type ENT to install                         *
  *   ALL Servers                                 *
  *                                               *
  *   Type MAIN to Return to main Menu            *
  *                                               *
  *   Press X to Exit                             *
  *************************************************'
  
  $addorchange = Read-Host -Prompt 'Enter Choice'
  
  while( $addorchange -eq "X"){
      Write-Host "Exiting Right Fax System Install"
      Break
  }
  
  if ($addorchange -like "ENT"){ENTInstall($addorchange)}
  if ($addorchange -like "APP"){APPInstall($addorchange)}
  if ($addorchange -like "TYP"){TYPInstall($addorchange)}
  if ($addorchange -like "RDT"){RDTInstall($addorchange)}
  if ($addorchange -like "WEB"){WEBInstall($addorchange)}
  if ($addorchange -eq "MAIN"){MAIN($addorchange)}
  }

Start_InstallMenu($select)