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

Write-Host -ForegroundColor Green "Processing Server  Line 31" $S


Write-Host -ForegroundColor Green "Creating Directories for server Line 34" $S
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command1
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command2
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command3
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command4
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command5
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command6
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock $command7
Write-Host -ForegroundColor Green "Directories Created"
Write-Host -ForegroundColor Green "Copying RightFax Directory from Seed Server to" $S "E:\Software"
$Source='\\apvest23418\e$\software\RightFax'
$Dest = "\\$s\e$\software\"
Copy-Item -Path $Source -Destination $Dest -Recurse
start-sleep -Seconds 30


invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
Register-ScheduledTask -xml (Get-Content e:\Software\RightFax\Optum_installer.xml | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force 
start-sleep -Seconds 4
}

Write-Host -ForegroundColor Green "Disable Security Prompt  Line 55" $S
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
 Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0'
}

Write-Host -ForegroundColor Green "REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v  Line 27 " $S
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0'
}

Write-Host -ForegroundColor Green "Install Windows Features For IIS  Line 65" $S
invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    start-sleep -Seconds 4
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
    #Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibrabriaries 
    #Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Server
    start-sleep -Seconds 4
}

Write-Host -ForegroundColor Green "Starting the Install of IIS for server  Line 75" $S

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

 $Location = 'E:\msmq'

 Write-host -ForegroundColor Green "Location  Line 158" $Location $S

 If(!(test-path $Location)){

 New-Item -ItemType Directory -Force -Path $Location

 }

 Write-host -ForegroundColor Green "Taking Ownership  Line 166" $S

 takeown /F $Location /R /D y #this should give me ownership of both msmq and LQS folder

 icacls $Location /reset /T /C

 icacls $Location "/grant:r" "NT AUTHORITY\SYSTEM:(OI)(CI)(M)" /T /C

 $ConfirmPreference = 'None'

 }
 }

 function PrepServer2{

 Write-Host -ForegroundColor Green "Install Windows Features For MSMQ  Line 178" $S

 invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {

 Write-Host -ForegroundColor Green "Install Windows Features For MSMQ  Line 181" $S
 Install-WindowsFeature -name MSMQ-Server -IncludeManagementTools

 Write-Host -ForegroundColor Green "Install Windows Features For MSMQ  Line 184" $S
 start-sleep -Seconds 4

 Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Server

 Write-Host -ForegroundColor Green "Install Windows Features For MSMQ  Line 189" $S
 Set-MsmqQueueManager -MsgStore $Location -TransactionLogStore $Location -MsgLogStore $Location
 start-sleep -Seconds 4

 Write-Host -ForegroundColor Green "Completed MSMQ Services configure for server Line 191" $S

Write-Host -ForegroundColor Green "Setting System Environment Variables  Line 193" $S
#invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {

    [System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User); [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User)
#}

# disable chef
 Disable-ScheduledTask -TaskName "chef-client"; Disable-ScheduledTask -TaskName "chef-client on restart"

 Write-Host -ForegroundColor Gree "Performing a Restart on Server " $S

}
}

function ServerInstall{
# remote to machine
cmdkey /generic:TERMSRV/$Server /user:$Username /pass:$Password
mstsc /v:$Server

Add-Type -AssemblyName System.Windows.Forms
start-sleep -Seconds 4



[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")


start-sleep -Seconds 4

Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {



 [System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User) ; [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User)  



}


pause


start-sleep -Seconds 4
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {



Start-ScheduledTask -TaskName "Optum_installer" -TaskPath "RightFax"



}
}

function Cleanup{
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {


# delete  scheduled task for Optume_installer.bat
#REG delete "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fPromptForPassword /f
Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '1'

Unregister-ScheduledTask -TaskName "Optum_installer" -Confirm:$false

Enable-ScheduledTask -TaskName "chef-client"; Enable-ScheduledTask -TaskName "chef-client on restart"


}
}


foreach($Server in $Serversfile){
$s = $Server
$Username = 'ms\arcnonprd'
$Password = 'mom519ug!'
$Serversfile = Get-Content servers.txt
$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$select = ""
PrepServer($select)
PrepServer2($select)
Restart-Computer -ComputerName $Server -Wait -Delay 2 -force
start-sleep -Seconds 4

ServerInstall($select)
start-sleep -Seconds 600
Cleanup($select)
Restart-Computer -ComputerName $Server -Wait -Delay 2 -force
start-sleep -Seconds 4
}

