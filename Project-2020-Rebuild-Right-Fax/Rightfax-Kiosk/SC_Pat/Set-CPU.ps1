$Cred = Get-Credential
$serverList = gc Servers.txt
$CPU = Read-Host "Enter the Number of CPU'S"
ForEach ($server in $serverList)
{
$S = $server
$c = $CPU
#$processors = get-wmiobject -computername $S @($processors).count
#Write-Host -ForegroundColor Green "Cuurrent CPU Count" $processors
Write-Host -ForegroundColor Green "New CPU Count 1" $C
Write-Host -ForegroundColor Green "Server Name 1" $S

#Pause
#  Invoke-Command -ComputerName $S -Credential $Cred -ArgumentList $S, $C -ScriptBlock {
  $Cores = @($processors).count
  Write-Host -ForegroundColor Green "Cuurrent CPU Count" $Cores
  Write-Host -ForegroundColor Green "New CPU Count 2" $C
  Write-Host -ForegroundColor Green "Server Name 2" $S
  Pause
  Stop-VM -Name $S -Passthru | Set-VM -ProcessorCount $C -Passthru | Start-VM
  $Cores = @($processors).count
  Write-Host -ForegroundColor Green "Successfully Updated CPU's to" $Cores
  Pause
#  }
}