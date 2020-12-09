$Cred = Get-Credential
$serverList = get-Content Servers.txt
$NewFolder1 = "RFTemp"
$NewFolder2 = "MSMQ"
$NewFolder3 = "Utils"
$NewFolder4 = "XMLDumpster"
$NewFolder5 = "Bad_EDC"
$NewFolder6 = "Inetpub"
$NewFolder7 = "Software\Rightfax"

#Command to create folder using variables. 
$command1 = { New-Item -Path E:\$Using:NewFolder1 -ItemType Directory }
$command2 = { New-Item -Path E:\$Using:NewFolder2 -ItemType Directory }
$command3 = { New-Item -Path E:\$Using:NewFolder3 -ItemType Directory }
$command4 = { New-Item -Path E:\$Using:NewFolder4 -ItemType Directory }
$command5 = { New-Item -Path E:\$Using:NewFolder5 -ItemType Directory }
$command6 = { New-Item -Path E:\$Using:NewFolder6 -ItemType Directory }
$command7 = { New-Item -Path E:\$Using:NewFolder7 -ItemType Directory }
ForEach ($server in $serverList){
$S = $server
Write-Host -ForegroundColor Green "Doing a server Restat starting the install" $S
#Restart-Computer –ComputerName $S -wait -For Powershell -Timeout 60
Write-Host -ForegroundColor Green "Creating Directories for server" $S
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command1
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command2
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command3
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command4
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command5
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command6
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command7
Write-Host -ForegroundColor Green "Directories Created"
Write-Host -ForegroundColor Green "Copying RightFax Directory from Seed Server to E:\Software" $S
$Source='\\apvest23418\e$\software\RightFax\*.*'
$Dest = "\\$s\e$\software\Rightfax"
Copy-Item -Path $Source -Destination $Dest -Recurse
Write-Host -ForegroundColor Green "Starting the Install of IIS for server" $S
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
  function Test-PendingReboot
{
 if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { return $true }
 if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { return $true }
 if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { return $true }
 #try { 
  # $util = [wmiclass]"\.\root\ccm\clientsdk:CCM_ClientUtilities"
  # $status = $util.DetermineIfRebootPending()
  #if(($status -ne $null) -and $status.RebootPending){
    # return $true
     
  #}
 }catch{}
}
Clear-Host
If (Test-PendingReboot)
    {"ERROR: Server Pending Reboot from previous changes. Please reboot and run this script again."
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
    Write-Host "ERROR:"$NewDrive":\ drive does not exist, stopping"
	Return
}

Add-WindowsFeature web-server
Add-WindowsFeature Web-Mgmt-Console
Add-WindowsFeature WAS-Process-Model
Add-WindowsFeature WAS-Config-APIs

# Confirm IIS Installed
if ((Get-WindowsFeature -Name Web-Server).InstallState -ne "Installed") {
	Write-Host "ERROR: IIS not installed, stopping for server" $S
	Return
}

# Stop Services
Write-Host "INFO: Stopping IIS for server" $S
$StopIIS = &iisreset /stop

# Move Inetpub directory
Write-Host "INFO: Moving inetpub directoy to $NewPath"
$MoveFiles = &Robocopy C:\inetpub $NewPath *.* /MOVE /S /E /COPYALL /R:0 /W:0

# Modify Registry
Write-Host "INFO: Updating Registry"
$RegUpdate = New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\InetStp" -Name "PathWWWRoot" -Value $NewPath"\wwwroot" -PropertyType ExpandString -Force
$RegUpdate = New-ItemProperty -Path "HKLM:\System\CurrentControlSet\Services\WAS\Parameters" -Name "ConfigIsolationPath" -Value $NewPath"\temp\appPools" -PropertyType String -Force
$RegUpdate = New-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\InetStp" -Name "PathWWWRoot" -Value $NewPath"\wwwroot" -PropertyType ExpandString -Force

# Backup and modify applicationHost.config file
Write-Host "INFO: Backing up config file"
copy-item C:\Windows\System32\inetsrv\config\applicationHost.config C:\Windows\System32\inetsrv\config\applicationHost.config.bak
Start-Sleep 10

# Replace "%SystemDrive%\inetpub" with $NewDrive":\inetpub"
Write-Host "INFO: Updating config file"
(Get-Content C:\Windows\System32\inetsrv\config\applicationHost.config).replace("$OldPath","$NewPath") | Set-Content C:\Windows\System32\inetsrv\config\applicationHost.config

# Update IIS Config
Write-Host "INFO: Updating appcmd config"
$UpdateConfig = &C:\Windows\system32\inetsrv\appcmd set config -section:system.applicationhost/configHistory -path:$NewPath\history

# Start services
Write-Host "INFO: Starting IIS"
$StartIIS = &iisreset /start

Write-Host "INFO: Completed"

Write-Host "Configuring MSMQ Service on server" $S
$Location = 'E:\msmq'
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
  $Location = '\\$s\E$\msmq'
  If(!(test-path $Location)){
    New-Item -ItemType Directory -Force -Path $Location
  }
takeown /F $Location /R /D y #this should give me ownership of both msmq and LQS folder
icacls $Location /reset /T /C
icacls $Location "/grant:r" "NT AUTHORITY\NetworkService:(OI)(CI)(M)" /T /C
$ConfirmPreference = 'None'

Set-MsmqQueueManager -MsgStore $Location -TransactionLogStore $Location -MsgLogStore $Location
}
Write-Host -ForegroundColor Green "Completed MSMQ Services configure for server" $S
Invoke-Command -ComputerName $S -Credential $Cred -ScriptBlock {
  Write-Host -ForegroundColor Green "Starting Install oStart-Pf Right Fax for server" $S
  Start-Process "\\$s\e$\Software\RightFax\Optuminstall.bat"
  Write-Host -ForegroundColor Green "Successfully completed Install of Right Fax" 
}
}