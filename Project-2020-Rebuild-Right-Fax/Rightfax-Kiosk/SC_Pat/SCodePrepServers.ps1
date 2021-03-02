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

function Main{
  Invoke-expression -Command .\UCodeMaster.ps1
}

function APPPrep{ 

foreach($Server in $Serversfile){ 
  $s = $Server 

  PrepServer2
  PrepServer4
  PrepServer5
   
} 
#End of PrepServer Function
Start_PrepMenu($select)
} 

function RDTPrep{ 

foreach($entryRDT in $ServersRDT){ 
  $r = $entryRDT
   $s = $r



PrepServer2
  PrepServer4
  PrepServer5
   
} 
#End of PrepServer Function
Start_PrepMenu($select)
} 


function WEBPrep{ 

foreach($entryWEB in $ServersWEB){ 
  $w = $entryWEB 
   $s = $w


PrepServer2
  PrepServer4
  PrepServer5
   
} 
#End of PrepServer Function
Start_PrepMenu($select)
} 

function ENTIREPrep{ 
foreach($entryENT in $ServersALL){ 
  $a = $entryENT 
   $s = $a





  PrepServer2
  PrepServer4
  PrepServer5
   
} 
#End of PrepServer Function
Start_PrepMenu($select)
} 




function PrepServer2{
Write-Host -ForegroundColor Red "Starting Function PrepServer2"

Write-Host -ForegroundColor Green "Setting admin group for service account"$S  

$adminGroup = [ADSI]"WinNT://$server/Administrators"  
$adminGroup.add("WinNT://MS/EFXDev_Ark")  
  "$server`tSuccess"  
  "$server`tSuccess" | Out-File -FilePath .\results.txt -Append  

Write-Host -ForegroundColor Green "Install Windows Features For IIS  Line 65" $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
    Install-WindowsFeature -name Web-Server -IncludeManagementTools 
    start-sleep -Seconds 4 
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication 
    start-sleep -Seconds 4 
} 

Write-Host -ForegroundColor Green "Starting the Install of IIS for server  Line 101" $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
  if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { return $true } 
  if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { return $true } 
  if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { return $true } 
  $util = [wmiclass]"\.\root\ccm\clientsdk:CCM_ClientUtilities" 
  $status = $util.DetermineIfRebootPending() 
  if(($status -ne $null) -and $status.RebootPending) { 
    Write-Host -ForegroundColor Red "Pending Reboot  Line 84" $S 
    return $true 
   } 

If (Test-PendingReboot) 
 {"ERROR: Server Pending Reboot from previous changes. Please reboot and run this script again." 
 Write-Host -ForegroundColor Red "Server Pending Reboot from previous changes. Please reboot and run this script again.  Line 90" $S 
 Return 
 } 
Else 
{"PASS: Server NOT Pending Reboot.  IIS Install and Move to E: continuing." 

}     
  
$NewDrive = "E" 
$OldPath = "%SystemDrive%\inetpub" 
$NewPath = $NewDrive+":\inetpub" 

# Confirm new drive exists 

if (!(Test-Path $NewDrive":\")) { 
  Clear-Host 
  Write-Host -ForegroundColor Red "ERROR:"$NewDrive":\ drive does not exist, stopping  Line 104" $S 
  Return 
} 
  
Add-WindowsFeature web-server 
Add-WindowsFeature Web-Mgmt-Console 
Add-WindowsFeature WAS-Process-Model 
Add-WindowsFeature WAS-Config-APIs 

# Confirm IIS Installed 

if ((Get-WindowsFeature -Name Web-Server).InstallState -ne "Installed") { 
  Write-Host -ForegroundColor Red "ERROR: IIS not installed, stopping  Line 115" $S 
  Return 
} 

# Stop Services 

Write-Host -ForegroundColor Green "INFO: Stopping IIS  Line 120" $S 

$StopIIS = &iisreset /stop 

# Move Inetpub directory 

Write-Host -ForegroundColor Green "INFO: Moving inetpub directoy to $NewPath  Line 124" $S 

$MoveFiles = &Robocopy C:\inetpub $NewPath *.* /MOVE /S /E /COPYALL /R:0 /W:0 

# Modify Registry 

Write-Host -ForegroundColor Green "INFO: Updating Registry  Line 127" $S 

$RegUpdate = New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\InetStp" -Name "PathWWWRoot" -Value $NewPath"\wwwroot" -PropertyType ExpandString -Force 
$RegUpdate = New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\WAS\Parameters" -Name "ConfigIsolationPath" -Value $NewPath"\temp\appPools" -PropertyType String -Force 
$RegUpdate = New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\InetStp" -Name "PathWWWRoot" -Value $NewPath"\wwwroot" -PropertyType ExpandString -Force 

# Backup and modify applicationHost.config file 

Write-Host -ForegroundColor Green "INFO: Backing up config file  Line 134" $S 
copy-item C:\Windows\System32\inetsrv\config\applicationHost.config C:\Windows\System32\inetsrv\config\applicationHost.config.bak 
Start-Sleep 10 

# Replace "%SystemDrive%\inetpub" with $NewDrive":\inetpub" 

Write-Host -ForegroundColor Green "INFO: Updating config file" 
(Get-Content C:\Windows\System32\inetsrv\config\applicationHost.config).replace("$OldPath","$NewPath") | Set-Content C:\Windows\System32\inetsrv\config\applicationHost.config 

# Update IIS Config 

Write-Host -ForegroundColor Green "INFO: Updating appcmd config  Line 143" $S 

$UpdateConfig = &C:\Windows\system32\inetsrv\appcmd set config -section:system.applicationhost/configHistory -path:$NewPath\history 

# Start services 

Write-Host -ForegroundColor Green "INFO: Starting IIS  Line 147" $S 

$StartIIS = &iisreset /start 

Write-Host -ForegroundColor Green "INFO: IIS Completed  Line 150" $S 

} 

Write-Host -ForegroundColor Green "Configuring MSMQ Service on server  Line 153" $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
} 
#End of PrepServer2 Function
} 
function PrepServer4{ 

Write-Host -ForegroundColor Green "Enable SMB2 and configure SMB caching  Line 217" $S    

Invoke-Command -ComputerName $S -Credential $Cred -ScriptBlock {  

  Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanserver\Parameters\" -Name "SMB2" -Value 1  
  Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "FileInfoCacheLifetime" -Value 0  
  Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "FileNotFoundCacheLifetime" -Value 0  
  Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "DirectoryCacheLifetime" -Value 0  
}  
  
Write-Host -ForegroundColor Green "Settng print spooler to automatic startup type  Line 230" $S  

Invoke-Command -ComputerName $S -Credential $Cred -ScriptBlock {  
Set-Service -Name Spooler -Status Running -StartupType Automatic  

Write-Host -ForegroundColor Green "Settng TLS Registry Keys 240" $S                

Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled"  -Value 0  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledbyDefault" -Value 1  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled"  -Value 0  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledbyDefault" -Value 1  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -Value 0  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledbyDefault" -Value 1  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -Value 0  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledbyDefault" -Value 1  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "Enabled" -Value 1  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "DisabledbyDefault" -Value 0  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "Enabled" -Value 1  
Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "DisabledbyDefault" -Value 0  

Write-Host -ForegroundColor Green "Remove CreateSubkey access to registry   Line 319" $S    

#Remove CreateSubkey access to registry  

$b = Get-acl 'HKLM:\Software\Microsoft\SystemCertificates\Remote Desktop\Certificates'  
$c = New-Object System.Security.AccessControl.RegistryAccessRule ("NT AUTHORITY\System","CreateSubkey","Deny")  
$b.SetAccessRule($c)  
$b | Set-Acl -Path 'HKLM:\Software\Microsoft\SystemCertificates\Remote Desktop\Certificates'  

Write-Host -ForegroundColor Green "Setting Environment Variables  Line 249" $S  

[System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User) ; [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User)   
#End of Sets
}  
# End of PrepServer4 Function  
}  
function PrepServer5{

$s=$Server 

Write-Host -ForegroundColor Green "Setting System Environment Variables  Line 316" $Server 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
  [System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User); [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User) 
  Write-Host -ForegroundColor Green "Disable Chef Line 268" $Server 

  # disable chef 

  Disable-ScheduledTask -TaskName "chef-client" 
  Disable-ScheduledTask -TaskName "chef-client on restart" 
  Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installer.xml' | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force  
  Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installerRDT.xml' | out-string) -TaskName "Optum_installerRDT" -TaskPath "RightFax" -Force 
  Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installerWEB.xml' | out-string) -TaskName "Optum_installerWEB" -TaskPath "RightFax" -Force 
  Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installerAPP.xml' | out-string) -TaskName "Optum_installerAPP" -TaskPath "RightFax" -Force
  
  
  
  start-sleep -Seconds 4 

  Write-Host -ForegroundColor Green "Disable Security Prompt  Line 270" $S 

  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0' 

  Write-Host -ForegroundColor Green "REG add HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" $S 

  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0' 
} 
#End of PrepServer5 Function
} 

function Start_PrepMenu{ 

  Write-Host '
  *************************************************
  *   Right Fax prep System - prep Menu     *
  *************************************************
  *   Type APP to prep                            *
  *   APP ONLY Servers                            *
  *                                               *  
  *   Type TYP to prep                            *
  *   APP & RDT Servers                           *                                          
  *                                               *   
  *   Type RDT to prep                            *
  *   RDT ONLY Servers                            *
  *                                               * 
  *   Type WEB to prep                            *
  *   WEB ONLY Servers                            *  
  *                                               * 
  *   Type ENT to prep                            *
  *   ALL Servers                                 *
  *                                               *
  *   Type MAIN to Return to main Menu            *
  *                                               *
  *   Press X to Exit or Enter to Continue        *
  *************************************************
  '
  $addorchange = Read-Host -Prompt 'Enter Choice'
  
  while( $addorchange -like "x"){
      Write-Host "Exiting Right Fax System prep"
      Break
  }
  
  if ($addorchange -like "ENT"){ENTIREPrep($addorchange)}
  if ($addorchange -like "APP"){APPPrep($addorchange)}
  if ($addorchange -like "TYP"){TYPPrep($addorchange)}
  if ($addorchange -like "RDT"){RDTPrep($addorchange)}
  if ($addorchange -like "WEB"){WEBPrep($addorchange)}
  if ($addorchange -like "MAIN"){MAIN($addorchange)}
  }
Start_PrepMenu($select)