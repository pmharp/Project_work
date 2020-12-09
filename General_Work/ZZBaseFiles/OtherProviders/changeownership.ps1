$Cred = Get-Credential
$serverList = gc Servers.txt
ForEach ($server in $serverList)
{
$S = $server
Invoke-Command -ComputerName $server -Credential $Cred -ScriptBlock {
  Write-Host -ForegroundColor Green "Starting Change Ownership Servers" 
  $Device_Object = $server
  $CurrentRegOwner = 'pharp@ms.ds.uhc.com'
  $NewRegOwner = 'krpice26@ms.ds.uhc.com'
  Write-Host -ForegroundColor Green "Successfully Change Ownership Servers" 
}
}
