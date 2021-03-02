$Username = Read-Host -Prompt 'Input the user name'
$Password = Read-Host 'What is your password?' -AsSecureString
$pass = ConvertTo-SecureString -AsPlainText $Password -Force 
$Cred = New-Object System.Management.Automation.PSCredential -ArgumentList $Username,$pass

Invoke-Expression "& .\Master_Menu.ps1 -Credential $Cred"

