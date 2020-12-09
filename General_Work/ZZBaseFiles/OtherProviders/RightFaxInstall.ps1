$Username = 'ms\pharp101'
$Password = 'iBoieX9,'
$pass = ConvertTo-SecureString -AsPlainText $Password -Force
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass
$addorchange = ""
 
function PrepServer{
 
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
 
# import scheduled task for Optume_installer.bat
 
Register-ScheduledTask -xml (Get-Content e:\Software\RightFax\Optum_installer.xml | out-string) -TaskName "Optum_installer" -TaskPath "RightFax" -Force 
start-sleep -Seconds 4
 
 
#Remove / Disable old TLS protocols and enable TLS 1.2
Invoke-Command -ComputerName $Server -ScriptBlock {
               
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "Enabled" -PropertyType "DWORD" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server" -Name "DisabledbyDefault" -PropertyType "DWORD" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "Enabled" -PropertyType "DWORD" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client" -Name "DisabledbyDefault" -PropertyType "DWORD" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "Enabled" -PropertyType "DWORD" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server" -Name "DisabledbyDefault" -PropertyType "DWORD" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "Enabled" -PropertyType "DWORD" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client" -Name "DisabledbyDefault" -PropertyType "DWORD" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "Enabled" -PropertyType "DWORD" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server" -Name "DisabledbyDefault" -PropertyType "DWORD" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "Enabled" -PropertyType "DWORD" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client" -Name "DisabledbyDefault" -PropertyType "DWORD" -Value 0
            }
            $status = "Success"
        
        Catch {
            $status = "Failed"
        }
 
start-sleep -Seconds 4
 
Invoke-command -Computername $Server -Credential $Cred -ScriptBlock {
 
    Install-WindowsFeature -name Web-Server -IncludeManagementTools
    start-sleep -Seconds 4
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-WindowsAuthentication
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-LoggingLibrabriaries 
    Enable-WindowsOptionalFeature -Online -FeatureName MSMQ-Server
    start-sleep -Seconds 4
    New-Item -Type "directory" -Path "E:\" -Name "RFTemp"
    New-Item -Type "directory" -Path "E:\" -Name "MSMQ"   
    New-Item -Type "directory" -Path "E:\" -Name "Inetpub"
    New-Item -Type "directory" -Path "E:\" -Name "BAD_EDC"
    New-Item -Type "directory" -Path "E:\" -Name "Utils"
    New-Item -Type "directory" -Path "E:\" -Name "XMLDumpster"
    }
 
 
    # disable security prompt
Set-Itemproperty -path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services' -Name 'fPromptForPassword' -value '0'
#REG add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v fPromptForPassword /t REG_DWORD /d 0 /f
 
 
# disable chef
Disable-ScheduledTask -TaskName "chef-client"; Disable-ScheduledTask -TaskName "chef-client on restart"
 
 
#startsspoolersetstartuptype
 
Invoke-Command -ComputerName $Server -ScriptBlock {
       Set-Service -Name Spooler -Status Running -StartupType Automatic
            }
 
 
 
#create directoriesneeded for RightFax
Invoke-Command -ComputerName $Computers -ScriptBlock {
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanserver\Parameters\" -Name "SMB2" -Value 1
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "FileInfoCacheLifetime" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "FileNotFoundCacheLifetime" -Value 0
                Set-ItemProperty -Path "HKLM:SYSTEM\CurrentControlSet\Services\Lanmanworkstation\Parameters\" -Name "DirectoryCacheLifetime" -Value 0
            }
            $status = "Success"
        }
        Catch {
            $status = "Failed"
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
 
$Server = Read-Host -Prompt 'Type server name you want to work on'
 
while( $addorchange -notlike "x"){
$addorchange = Read-Host -Prompt '
To Prep Server ready for install, type prep
To Install RightFax, type install
To Cleanup after install, type clean
To Quit press X
'
if ($addorchange -like "prep"){PrepServer($addorchange);Restart-Computer -ComputerName $Server -Wait -Delay 2 -force}
if ($addorchange -like "install"){ServerInstall($addorchange)}
if ($addorchange -like "clean"){Cleanup($addorchange);Restart-Computer -ComputerName $Server -Wait -Delay 2 -force}
 
}
