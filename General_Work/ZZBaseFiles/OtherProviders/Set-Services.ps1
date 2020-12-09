$Cred = Get-Credential
$serverList = gc Servers.txt
ForEach ($server in $serverList)
{
$S = $server
Invoke-Command -ComputerName $server -Credential $Cred -ScriptBlock {
  Set-Service -Name PLA -StartupType Automatic
  Write-Host -ForegroundColor Green "Successfully completed command" 
}
}