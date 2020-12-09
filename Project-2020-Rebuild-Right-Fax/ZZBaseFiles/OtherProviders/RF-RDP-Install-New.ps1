$NewFolder1 = "RFTemp" 
$NewFolder2 = "MSMQ" 
$NewFolder3 = "Utils" 
$NewFolder4 = "XMLDumpster" 
$NewFolder5 = "Bad_EDC" 
$NewFolder6 = "Inetpub" 
$NewFolder7 = "Software"
$Holdrdpset = "" 

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

function PrepServer{ 

ForEach ($server in $serverfile) {
  $S = $server
  If ($s -eq "") {
      Write-Host -ForegroundColor "All servers have been configured"
      Return
    }  
Pause
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
}
#End of PrepServer Function
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
  start-sleep -Seconds 4 

  Write-Host -ForegroundColor Green "Disable Security Prompt  Line 270" $S 

  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0' 

  Write-Host -ForegroundColor Green "REG add HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" $S 

  Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0' 
} 
#End of PrepServer5 Function
} 

Function DisplayRDTtoServer{
 

$vms = Get-Content serversAPP.txt 
$hosts = Get-Content serversRDP.txt 
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
$ServersRDP = Get-Content serversRDP.txt 
#$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $MSID,$MSPass  
$RDPCount = 1 
$select = "" 
$holdApp = 1 
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
$SuidLic = Get-Content Suid.txt  
$ServersRDP2 = Get-Content serversRDP.txt
$ServersAPP2 = Get-Content serversApp2.txt
$RDPCount2 = 1 
$select2 = "" 
$holdApp2 = 0
$holdrdp2 = 0
$Suidset = 0 
$linecount2 = $ServersApp.count 
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
  $SUID = $SUIDLIC[$SUIDSet]
  Write-Host -ForegroundColor Green " Writing SUID License to APP Server" $SA2 
  [xml]$myXML = Get-Content -Path "\\$SA2\e$\Software\RightFax\POC_APP_SERVER_INSTALL.xml" 
  $myXML.CommonInstallSettings.SUID = "$SUIDLIC" 
  $myXML.Save("\\$SA2\e$\Software\RightFax\POC_APP_SERVER_INSTALL.xml")  
  Write-host "Tags are set for App Server " $SA2 
  $holdapp2 ++
  $SuidSet ++ 
  ReadApp2($select2) 
} 
else{ 
  
  $SR2 = $ServersRDP2[$holdrdp2] 
  $RDPCount2 ++ 
  Write-Host -ForegroundColor Green " Writing Server name to RDT Server" $SR2 $SA2 
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

}
         
#End of WriteRDTXML Function

Function Set-AutoLogon{
Write-Host -ForegroundColor Red "Starting Function Set-AutoLogon"

Write-Host -ForegroundColor Green "REG add "Autologon"  Line 27 " $S 

invoke-command -ComputerName $server -Credential $Cred -ScriptBlock { 
  $Server = 'Wn000005553' 
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
#End of Set-AutoLogon Function
} 
function ServerLogOn{
Write-Host -ForegroundColor Red "Starting Function ServerLogon" 

# remote to machine 

Write-Host -ForegroundColor Green "Logging on To Server Line 351" $Server    
start-sleep -Seconds 5 
cmdkey /generic:TERMSRV/$Server /user:$Username /pass:$Password 
mstsc /v:$Server 
Add-Type -AssemblyName System.Windows.Forms 
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
start-sleep -Seconds 20
#End of ServerLogOn Function
}
function ServerInstall{
Write-Host -ForegroundColor Red "Starting Function Server Install" 
$s = $Server 
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock { 
  $s = $Server 
  Write-Host -ForegroundColor Green "installing Optum_installer  Line 372" $S  
  Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installer.xml' | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force  
  start-sleep -Seconds 10 
  Write-Host -ForegroundColor Green "Running Optum_installer  Line 375" $S  
  Start-ScheduledTask -TaskName "Optum_installer" -TaskPath "RightFax" 
} 
#End of ServerInstall Function
} 
function Cleanup{
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

  Write-Host -ForegroundColor Green "Re-enabling Chef- Client and Chef-Client on Restart  Line 396" $S  

  Enable-ScheduledTask -TaskName "chef-client"; Enable-ScheduledTask -TaskName "chef-client on restart" 

  } 
#End of Cleanup Function
} 

#Functions to run subfunctions 
function StartFileCopy{ 

  foreach($Server in $Serversfile){ 
  $s = $Server 

  Write-host -ForegroundColor Green "Begin File Copy Function Line 409" $S 
} 
#End of StartFileCopy Function
} 
function StartInstallPrep{ 

foreach($Server in $Serversfile){ 
$s = $Server 

Write-host -ForegroundColor Green "Prep Server 2 loop Function Line 408" $S 

PrepServer2($select) 

Write-host -ForegroundColor Green "Prep Server 3 loop Function Line 410" $S 

PrepServer5($select) 

Restart-Computer -ComputerName $S -Wait -Delay 2 -force 
} 
#End of StartInstallPrep Function
} 
function StartInstall{ 

$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$Serversfile = Get-Content serversAPP.txt 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
$select = "" 

foreach($Server in $Serversfile){ 
  $s = $Server 
  Set-AutoLogon($select) 
  Write-Host -ForegroundColor Gree "Performing a Server Logon loop Function Line 431" $S 
  ServerLogon($select) 
  Write-Host -ForegroundColor Gree "Performing a Server Install loop Function Line 433" $S 
  start-sleep -Seconds 4 
  ServerInstall($select) 
} 
#End of StartInstall Function
} 

function StartInstallCleanUp{ 

foreach($Server in $Serversfile){ 
 $s = $Server 
 $Username = 'ms\arcnonprd' 
 $Password = 'mom519ug!' 
 $Serversfile = Get-Content serversAPP.txt 
 $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
 $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 

$select = "" 

Write-host -ForegroundColor Green "Performing a Server CleanUp loop Function Line 436" $S 

Cleanup($select) 
start-sleep -Seconds 4 
} 
#End of StartInstallCleanUp Function
} 

Function Start_Collect{
Write-Host '
*************************************************
*           Right Fax Install System            *
*************************************************
*   Type in the name of your Seed Server        *
*   How many RDT Tags per App Server            *
*   Press X to Exit or Enter to Continue        *
*************************************************'
while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Install"
    Break
}

$addorchange = "Collect"

while( $addorchange -notlike "x"){  
$SeedServer = Read-Host -Prompt 'Enter Seed Server'
$RDPSet = Read-Host -Prompt 'RDP'  
$APPHold = Get-Content serversAPP.txt
$RDPHold = Get-Content serversRDP.txt
$LineAPP = $APPHold.count
$LineRDP = $RDPHold.count
$LineAns = $LineRDP / $RDPSET
If ($lineAns -ne $LineApp){
  Write-Host "There is a mis match between RDT and APP servers"
  Write-Host "RDT Server Count: " $LineRDP
  Write-Host " App Server Count: " $LineApp
  Break
}

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

Write-Host "Add or Change Var " $addorchange
if ($addorchange -like "collect"){DisplayRDTtoServer($addorchange)} 

#End of the While Not Like Loop 
}  
Start_Menu($select)
}

function Start_Process{
    $Username = 'ms\arcnonprd' 
    $Password = 'mom519ug!' 
    $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
    $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
    $select = ""
    $Serverfile = Get-Content serversAPP.txt
    Start_Install($select)
}

function Start_Copy{
  Write-Host -ForegroundColor Green "Start File Copy Funtion"
  $Serverfile = Get-Content servers.txt
  Prepserver($select)
  start-sleep -Seconds 30
}
function Start_Install{
  
    Write-Host -ForegroundColor Green "Installing Windows Features" $S
    PrepServer2($select)
    start-sleep -Seconds 30 
    Write-Host -ForegroundColor Green "Enable SMB2 and configure SMB caching" $S
    PrepServer4($select)
    start-sleep -Seconds 30
    Write-Host -ForegroundColor Green "Setting System Environment Variables  Line 316" $S
    PrepServer5($select)
    start-sleep -Seconds 30
    Write-Host -ForegroundColor Green "Start Install CleanUp Function" $S
    StartInstallCleanup($select)
    Write-Host -ForegroundColor Green "Installation Completed"
} 

function Start_Menu{

}

Write-Host '
*************************************************
*           Right Fax Install System            *
*************************************************
*   Type Install To Install RightFax Software   *
*   on Servers                                  *
*                                               *
*   Type Collect To Set RDT Board servers to Fax*
*   Appilcation per Collective                  *
*                                               *
*   Type Copy to Setup Directories and copy     *
*   software on servers                         *
*                                               *
*   Press X to Exit or Enter to Continue        *
*************************************************'

while( $addorchange -like "x"){
    Write-Host "Exiting Right Fax System Install"
    Break
}

$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "Install"){Start_Process($addorchange)}
if ($addorchange -like "Copy"){Start_Copy($addorchange)}
if ($addorchange -like "Collect"){Start_COllect($addorchange)}

#Start Processing

$s = $Server 
$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$Serversfile = Get-Content serversAPP.txt 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
$select = "" 
Start_menu($select)