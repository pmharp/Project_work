$Cred = Get-Credential
Pause
$serverList = gc Servers.txt

ForEach ($server in $serverList)
{
$S = $server
$Location = 'E:\msmq'

If(!(test-path $Location))
{
     New-Item -ItemType Directory -Force -Path $Location
}

takeown /F $Location /R /D y #this should give me ownership of both msmq and LQS folder
icacls $Location /reset /T /C
icacls $Location "/grant:r" "NT AUTHORITY\NetworkService:(OI)(CI)(M)" /T /C
$ConfirmPreference = 'None'

Set-MsmqQueueManager -MsgStore $Location -TransactionLogStore $Location -MsgLogStore $Location

Start-Service MSMQ
Invoke-Command -ComputerName $S -Credential $Cred -ScriptBlock {
  Write-Host -ForegroundColor Green "Starting Install" 
  #Start-Process \\apvest23420\e$\software\RightFax\setup.exe/Unattended=true/allowShutdown=true/Settings=POC_APP_Server_Install.xml
  Write-Host -ForegroundColor Green "Successfully completed Install" 
}
}