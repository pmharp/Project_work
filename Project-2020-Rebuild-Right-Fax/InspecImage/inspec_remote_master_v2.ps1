Add-Type -AssemblyName System.Windows.Forms
#Set-ExecutionPolicy unrestricted

# Check if file exists
$DestinationFile = 'c:\temp\optum_windows_inspec-danny.zip'
if (Test-Path $DestinationFile) {remove-item $DestinationFile}

# Check if inspec_results folder exists
if (Test-Path "C:\Users\$env:username\Documents\inspec_results") {Remove-Item "C:\Users\$env:username\Documents\inspec_results" -recurse}

# Create inpec_results folder
New-Item -Path "C:\Users\$env:username\Documents" -Name "inspec_results" -ItemType "directory"

# Check if inspec.zip exists
if (Test-Path "C:\Users\$env:username\Documents\inspec_results.zip") {Remove-Item "C:\Users\$env:username\Documents\inspec_results.zip"}


# Download zip file
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri "https://inspec.s3api-dmz.uhc.com/optum_windows_inspec-danny.zip" -OutFile "c:\temp\optum_windows_inspec-danny.zip"


$servers_files = "c:\temp\servers.txt"
Out-File -filepath $servers_files
Get-Acl C:\Users\$env:username\Documents | Set-Acl C:\temp\servers.txt
# Added to prevent Forms error
#Add-Type -AssemblyName System.Windows.Forms
#[System.Windows.Forms.MessageBox]::Show("c:\temp\servers.txt has been created on this machine. It will open after you click OK. Please populate this file with your server list, one server name per line.",'servers.txt created')
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show("c:\temp\servers.txt has been created on this machine. It will open after you click OK. Please populate this file with your server list, one server name per line.",'servers.txt created')
Start-Process notepad.exe $servers_files -Wait
$RemoteComputers  = Get-Content "C:\temp\servers.txt"
if ($RemoteComputers -eq $null) {
    [System.Windows.Forms.MessageBox]::Show('There are no servers listed in your c:\temp\servers.txt file. Please try again.','Job Finished')
    exit
}
else {
#$RemoteComputers = @("faxws0053","faxws0054")
$path = "c:\temp\$Computer.json"
$source = "C:\temp\optum_windows_inspec-danny.zip"
$destination = "c$\temp\"
#$file = "test_inspec\postbuild_qa.rb"

#New email code

#Should be before looping thru each server check
[void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
#Prompt for email address
$user = [Microsoft.VisualBasic.Interaction]::InputBox("Enter your email address", "Email Address")
#SMTP server name
$SmtpServer = "mailo2.uhc.com"

#Should be inside server check loop
#Send-MailMessage -SmtpServer $SmtpServer -From $user -To $user -Subject "InSpec Results" -Attachments "c:\users\$env:username\Documents\apsed3425_qa.html"

ForEach ($Computer in $RemoteComputers)
{
     Try
         {
             if (Test-Path "\\$Computer\$destination\optum_windows_inspec-danny.zip") {remove-item "\\$Computer\$destination\optum_windows_inspec-danny.zip"} 
             Copy-Item $source -Destination ("\\$Computer\$destination") -Recurse
             Invoke-Command -ComputerName $Computer -ErrorAction Ignore -ScriptBlock  {
                cd C:\opscode\chef\embedded\bin; 
                cmd.exe /c "inspec exec C:\temp\optum_windows_inspec-danny.zip --reporter html:/temp/%computername%.html" --chef-license=accept
             } 
             Copy-Item -Path ("\\$Computer\$destination\$Computer"+".html") -Destination "C:\Users\$env:username\Documents"
             Copy-Item -Path ("\\$Computer\$destination\$Computer"+".html") -Destination "C:\Users\$env:username\Documents\inspec_results"
             
         }
     Catch
         {
             Add-Content -Path C:\Users\$env:username\Documents\Unavailable-Computers.txt -Value $Computer
         }

}
Compress-Archive -Path "C:\Users\$env:username\Documents\inspec_results" -DestinationPath "C:\Users\$env:username\Documents\inspec_results"
Send-MailMessage -SmtpServer $SmtpServer -From $user -To $user -Subject "InSpec Results" -Attachments "c:\users\$env:username\Documents\inspec_results.zip"
[System.Windows.Forms.MessageBox]::Show('InSpec has completed. You should see HTML files, named for your servers, in your Documents.','Job Finished')
}