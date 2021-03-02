$Username = 'ms\arcnonprd' 
$Password = 'mom519ug!' 
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass 
$ServersRDT = Get-Content serversRDT.txt 

foreach($entryRDT in $ServersRDT){ 
  $r = $entryRDT

Copy-Item "E:\Software\RightFax\POC_RDT_SERVER_INSTALL.xml" -Destination "\\$r\E$\software\RightFax\" -Force



Write-Host -ForegroundColor Green "copied file on server $r" 

}