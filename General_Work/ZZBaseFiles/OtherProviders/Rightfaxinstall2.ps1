$Username = 'pharp101'
$Password = 'iBoieX9,'
$Serversfile = Get-Content servers.txt
$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$select = ""
 
function PrepServer{
 
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
 
# import scheduled task for Optume_installer.bat
Register-ScheduledTask -xml (Get-Content e:\Software\RightFax\Optum_installer.xml | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force 
 
# disable security prompt
Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0'
#REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fPromptForPassword /t REG_DWORD /d 0 /f
Install-WindowsFeature -name Web-Server -IncludeManagementTools
    start-sleep -Seconds 4
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibrabriaries 
    Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Server
    start-sleep -Seconds 4
# disable chef
Disable-ScheduledTask -TaskName "chef-client"; Disable-ScheduledTask -TaskName "chef-client on restart"
 
Restart-Computer –Computername $Server
 
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
 
 
 
#New-Item -ItemType "directory" -Path "E:\" -Name "E:\RFTemp";   New-Item -ItemType "directory" -Path "E:\" -Name "E:\MSMQ"  
 
 
 
}
 
 
start-sleep -Seconds 4
 
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
 
 
 
[System.Environment]::SetEnvironmentVariable('TMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User) ; [System.Environment]::SetEnvironmentVariable('TEMP', 'E:\RFTemp',[System.EnvironmentVariableTarget]::User)  
 
 
 
}
 
 
 
 
 
 
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
 if ($Server = ' ') {
    Write-Host "End" 
    Return
    }

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
    $S = $Server
    #Start PrepServer
    Write-Host -ForegroundColor Green "Creating Directories for server" $S
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command1
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command2
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command3
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command4
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command5
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command6
    invoke-command -ComputerName $Server -Credential $Cred -ScriptBlock $command7
    Write-Host -ForegroundColor Green "Directories Created"
    Write-Host -ForegroundColor Green "Copying RightFax Directory from Seed Server to E:\Software" $S
    $Source='\\apvest23418\e$\software\RightFax\*.*'
    $Dest = "\\$Server\e$\software\Rightfax"
    Copy-Item -Path $Source -Destination $Dest -Recurse
PrepServer($select)
Restart-Computer -ComputerName $Server -Wait -Delay 2 -force
start-sleep -Seconds 4
 
ServerInstall($select)
start-sleep -Seconds 600
Cleanup($select)
Restart-Computer -ComputerName $Server -Wait -Delay 2 -force
start-sleep -Seconds 4
}
