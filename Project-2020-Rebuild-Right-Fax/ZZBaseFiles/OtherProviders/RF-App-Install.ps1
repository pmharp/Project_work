$NewFolder1 = "RFTemp" 
$NewFolder2 = "MSMQ" 
$NewFolder3 = "Utils" 
$NewFolder4 = "XMLDumpster" 
$NewFolder5 = "Bad_EDC" 
$NewFolder6 = "Inetpub" 
$NewFolder7 = "Software" 

#Command to create folder using variables.  
$command1 = { New-Item -Path E:\$Using:NewFolder1 -ItemType Directory } 
$command2 = { New-Item -Path E:\$Using:NewFolder2 -ItemType Directory } 
$command3 = { New-Item -Path E:\$Using:NewFolder3 -ItemType Directory } 
$command4 = { New-Item -Path E:\$Using:NewFolder4 -ItemType Directory } 
$command5 = { New-Item -Path E:\$Using:NewFolder5 -ItemType Directory } 
$command6 = { New-Item -Path E:\$Using:NewFolder6 -ItemType Directory } 
$command7 = { New-Item -Path E:\$Using:NewFolder7 -ItemType Directory } 

function PrepServer{ 
Write-Host -ForegroundColor Green "Creating Directories for server" $S 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command1 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command2 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command3 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command4 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command5 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command6 
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command7 

Write-Host -ForegroundColor Green "Directories Created" 
Write-Host -ForegroundColor Green "Copying RightFax Directory from Seed Server to" $S "E:\Software" 

$SourcePath='\\apvest23418\e$\software\RightFax' 
$DestinationPath = "\\$s\e$\software\RightFax" 
$files = Get-ChildItem -Path $sourcePath -Recurse 
$filecount = $files.count 
$i=0 

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
function PrepServer2{ 

$adminGroup = [ADSI]"WinNT://$server/Administrators"  
  $adminGroup.add("WinNT://MS/EFXDev_Ark")  
  "$server`tSuccess"  
  "$server`tSuccess" | Out-File -FilePath .\results.txt -Append  
invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock { 

} 

Write-Host -ForegroundColor Green "Install Windows Features For IIS" $S 

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

} 
function PrepServer4{ 

Write-Host -ForegroundColor Green "Enable SMB2 and configure SMB caching  Line 217" $S  

Invoke-Command -ComputerName $S -Credential $Cred -ScriptBlock {  
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanserver\Parameters\" -Name "SMB2" -Value 1  
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "FileInfoCacheLifetime" -Value 0  
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "FileNotFoundCacheLifetime" -Value 0  
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "DirectoryCacheLifetime" -Value 0  

}  

Write-Host -ForegroundColor Green "Settng print spooler to automatic startup type " $S  

  

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

Write-Host -ForegroundColor Green "Remove CreateSubkey access to registry " $S    

#Remove CreateSubkey access to registry  
                $b = Get-acl 'HKLM:\Software\Microsoft\SystemCertificates\Remote Desktop\Certificates'  
                $c = New-Object System.Security.AccessControl.RegistryAccessRule ("NT AUTHORITY\System","CreateSubkey","Deny")  
                $b.SetAccessRule($c)  
                $b | Set-Acl -Path 'HKLM:\Software\Microsoft\SystemCertificates\Remote Desktop\Certificates'  

Write-Host -ForegroundColor Green "Remove Selfsigned Cert " $S    

Write-Host -ForegroundColor Green "Setting Environment Variables " $S  

[System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User) ; [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User)   

}  

}  
function PrepServer5{ 

$s=$Server 

Write-Host -ForegroundColor Green "Setting System Environment Variables " $Server 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 
    [System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User); [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User) 

# disable chef 

  Disable-ScheduledTask -TaskName "chef-client" 
  Disable-ScheduledTask -TaskName "chef-client on restart" 
  Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installer.xml' | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force  

  start-sleep -Seconds 4 

Write-Host -ForegroundColor Green "Disable Security Prompt" $S 

Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0' 

Write-Host -ForegroundColor Green "REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v  " $S 

Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0' 

} 

} 
function ServerLogOn{ 

# remote to machine 

Write-Host -ForegroundColor Green "Logging on To Server " $Server    

start-sleep -Seconds 5 

cmdkey /generic:TERMSRV/$Server /user:$Username /pass:$Password 
mstsc /v:$Server 

Add-Type -AssemblyName System.Windows.Forms 
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}") 

start-sleep -Seconds 20 

} 
function ServerInstall{ 

$s = $Server 
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock { 
$s = $Server 

Write-Host -ForegroundColor Green "installing Optum_installer " $S  

Register-ScheduledTask -xml (Get-Content 'e:\Software\RightFax\Optum_installer.xml' | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force  

start-sleep -Seconds 10 

Write-Host -ForegroundColor Green "Running Optum_installer " $S  

Start-ScheduledTask -TaskName "Optum_installer" -TaskPath "RightFax" 

} 

} 
function Cleanup{ 

Write-Host -ForegroundColor Green "Adding Registry Keys back  " $S 

invoke-command -ComputerName $s -Credential $Cred -ScriptBlock { 

Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticetext' -value 'Legal Notice' 
Set-Itemproperty -path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'legalnoticecaption' -value 'This is a private computer system containing confidential information. Any unauthorized attempt to access or use this computer system or any information on it by employees or other persons may result in termination of employment, civil fines, and criminal penalties. This system must be used for authorized business purposes only.' 

Write-Host -ForegroundColor Green "Initiating Cleanup" $S  

# delete  scheduled task for Optume_installer.bat 

Write-Host -ForegroundColor Green "... security prompt  " $S 

Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '1' 

Write-Host -ForegroundColor Green "Deleting Optum_installer " $S  

Unregister-ScheduledTask -TaskName "Optum_installer" -Confirm:$false 

Write-Host -ForegroundColor Green "Re-enabling Chef- Client and Chef-Client on Restart " $S  

Enable-ScheduledTask -TaskName "chef-client"; Enable-ScheduledTask -TaskName "chef-client on restart" 

} 

} 

#Functions to run subfunctions 

function StartFileCopy{ 

foreach($Server in $Serversfile){ 

$s = $Server 

Write-host -ForegroundColor Green "Begin File Copy Function" $S 


} 

} 

function StartInstallPrep{ 

foreach($Server in $Serversfile){ 

$s = $Server 

Write-host -ForegroundColor Green "Prep Server 2 loop Function" $S 

Write-host -ForegroundColor Green "Prep Server 3 loop Function" $S 

PrepServer5($select) 

Restart-Computer -ComputerName $S -Wait -Delay 2 -force 

} 

} 

function StartInstall{ 

    $s = $Server 
    $UserName = $MSID 
    $Password = $MSPass 
    $Serversfile = Get-Content servers.txt 
    $pass = ConvertTo-SecureString -AsPlainText $Password -Force 
    $Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName,$Password 
    $select = "" 

  foreach($Server in $Serversfile){ 

  $s = $Server 
  Set-AutoLogon($select) 

  Write-Host -ForegroundColor Gree "Performing a Server Logon loop Function" $S 

  ServerLogon($select) 

  Write-Host -ForegroundColor Gree "Performing a Server Install loop Function" $S 

  start-sleep -Seconds 4 

  ServerInstall($select) 

} 

} 
function StartInstallCleanUp{ 

foreach($Server in $Serversfile){ 

$s = $Server  
$UserName = $MSID 
$Password = $MSPass 
$Serversfile = Get-Content servers.txt 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName,$Password 
$select = "" 

Write-host -ForegroundColor Green "Performing a Server CleanUp loop Function" $S 

Cleanup($select) 

start-sleep -Seconds 4 

} 

} 

$s = $Server 
$MSID = Read-Host -Prompt 'Secondary Windows MS ID' 
$MSPass = Read-Host -Prompt 'Secondary Windows MS Password' -AsSecureString 
$Serversfile = Get-Content servers.txt 
$pass = ConvertTo-SecureString -AsPlainText $MSPass -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $MSID,$MSPass 
$select = "" 

Write-Host -ForegroundColor Green "Start File Copy Funtion" $S 

StartFileCopy 
start-sleep -Seconds 30 

Write-Host -ForegroundColor Green "StartInstallPrepFuntion" $S 

StartInstallPrep 
start-sleep -Seconds 30 

Write-Host -ForegroundColor Green "StartInstallFunction" $S 

StartInstall 
start-sleep -Seconds 30 

Write-Host -ForegroundColor Green "StartInstallCleanUpFunction" $S 

StartInstallCleanup 

Write-Host -ForegroundColor Green "the end " $S 