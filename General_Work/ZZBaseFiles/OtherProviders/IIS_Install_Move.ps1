# Created by Pat Harp
# Script Version: 2020.07.15
# Tested on Windows Server 2012r2, 2016, and 2019
#
# 2019-08-05: Script created to install IIS, and move it to E:\inetpub
# 2020-02-14: Added Pending Reboot check to address IIS install failures cause by pending system changes
# 2020-02-14: Added Target Drive Exist check
# ***************************************************************************
#
function Test-PendingReboot
{
 if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA Ignore) { return $true }
 if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA Ignore) { return $true }
 if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA Ignore) { return $true }
 try { 
   $util = [wmiclass]"\.\root\ccm\clientsdk:CCM_ClientUtilities"
   $status = $util.DetermineIfRebootPending()
   if(($status -ne $null) -and $status.RebootPending){
     return $true
   }
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
	Write-Host "ERROR: IIS not installed, stopping"
	Return
}

# Stop Services
Write-Host "INFO: Stopping IIS"
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