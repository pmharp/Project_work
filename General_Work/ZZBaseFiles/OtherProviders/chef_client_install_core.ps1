### NAME: Chef_client_install.ps1 ###
###
### DESCRIPTION: 
###    Binary install and configuration script for windows chef-client service.
###
### RUNBOOK:
###    1) Via Cisco AnyConnect - Workbench VPN
###    2) RDP to your chef-client target node.
###    3) Start PowerShell as Admin.
###    4) Navigate to CD C:\temp directory.
###    5) Locate/Download chef_client_install_xx_xx_xx.ps1 in artifactory and save it on your nodes C:\temp folder.   
###    6) To Execute script, enter the following command:  PS C:\temp> .\chef_client_install_xx_xx_xx.ps1 
###      
###
###
### RERUNS:  ******* IMPORTANT NOTE ********
### RERUNS:  If uninstalling the chef-client MSI package, 
### RERUNS:  a RESTART is MANDATORY prior to running this script.
### RERUNS:  ******* IMPORTANT NOTE ********    
###    
###
# Create and check temp folder

$Cred = Get-Credential
$serverList = get-Content Servers.txt

ForEach ($server in $serverList){
	$S = $server
	invoke-command -ComputerName $s -Credential $Cred -ScriptBlock {
   If(!(test-path C:\temp))
   {
   mkdir c:\temp
   }
   [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
   $msiin = "https://dooss.uhc.com/chef-clients/Windows_x86_64/chef-client-stable-x64.msi";
   $msiout = "C:\temp\chef-client-stable-x64.msi";
   $msilog = "C:\temp\chef_client_install_log.txt";
   $certin = "https://dooss.uhc.com/chef-clients/trusted_certs/chef_optum_com.crt"; 
   $certout = "c:\chef\trusted_certs\chef_optum_com.crt";
   $pemin = "https://dooss.uhc.com/chef-clients/validator/validator-production-optum.pem";
   #$pemdevin = "C:\temp\optum_iaasdev-validator.pem";
   $pemout = "c:\chef\validation.pem";
   $clientin = "https://dooss.uhc.com/chef-clients/Windows_x86_64/chef_client_rb_template.txt";
   #$clientdevin = "C:\temp\chef_client_rb_np_template.txt";
   $clientout = "c:\chef\client.rb";
   #$serviceName = "chef-client";
   #$retry = 3;  # Number of retry attempts starting chef-client.bat
   $begin = $(get-date)

   write-host "Create c:\chef\trusted_certs Directory";
   [system.io.directory]::CreateDirectory("C:\chef\trusted_certs");
   #Get chef server certificate from artifactory - *** Validate/Modify Server Cert. Name/Filename !!! ***
   write-host "Downloading chef_optum_com.crt from Artifactory";
   $ProgressPreference = 'SilentlyContinue'
   $i = Invoke-WebRequest -Uri $certin -OutFile $certout; 
   $i.ExitCode;
   ### get validator-production-optum.pem file from artifactory and saves it as c:\chef\validation.pem
   ###     *** Validate/Modify Chef Organization Name/Filename !!! ***
	write-host "Downloading validator-production-optum.pem from Artifactory";
	$w = Invoke-WebRequest -Uri $pemin -OutFile $pemout; 
	$w.ExitCode;

    ### Set variable name "$NodeName" with the value of Environment variable "HostName" 
    ### (HostName is an Environment Variable captured from the Node/VM where script is executed) 
    $NodeName = HostName;
    $FQDN=[System.Net.Dns]::GetHostByName(($env:computerName)).HostName
    $FQDN = $FQDN.ToLower()

    ### get client.rb file from artifactory

	write-host "Downloading client.rb configuration file from Artifactory";
	$rb = Invoke-WebRequest -Uri $clientin -OutFile $clientout; 
	$rb.ExitCode;


    ### replace text strings in client.rb file with variable $NodeName
    $fileContent = Get-Content 'c:\chef\client.rb' | Out-String
    $search  = 'apsrdxxxx.ms.ds.uhc.com'
    $fileContent | ForEach-Object { $_.Replace($search, $FQDN) } | Set-Content 'c:\chef\client.rb'
    write-host "*** Replaced configurable text with Environment Variable FQDN = $FQDN";

    ### Obtain MSI install package from artifactory - ***Validate/Modify Version/Filenames !!!***
    write-host "Downloading Chef-Client binary Install package from artifactory";
    $msrun = Invoke-WebRequest -Uri $msiin -OutFile $msiout;
    $msrun.ExitCode;

    ### Install chef-client MSI package - ***Validate/Modify Version/Filenames !!!*** - This is one command
    write-host "MSIEXEC Install of chef-client MSI package";

    msiexec.exe /i "C:\temp\chef-client-stable-x64.msi" /qn /l*v "$msilog" ADDLOCAL="ChefClientFeature,ChefPSModuleFeature"

    Start-Sleep -Seconds 120

    Write-Host "Running chef-client for first time"
    cmd /c "C:\opscode\chef\bin\chef-client -o optum_opsrun_asc"
    Start-Sleep -s 30
    Write-Host "Running chef-client for second time"
    cmd /c "C:\opscode\chef\bin\chef-client -o optum_opsrun_asc" 
    Start-Sleep -s 60
    Remove-Item "C:\temp\chef-client-stable-x64.msi" -Force
    #write-host "Delete c:\chef\validation.pem file"
    #      Remove-Item c:\chef\validation.pem
    #      write-host "End of Script - chef_client_install_xx_xx_xx.ps1"     

    ### Complete Scripting Steps ###
    write-host " ";
    $end = $(get-date); 
    write-host "Begin time $begin";
    write-host "End time $end";
    write-host " ";
    write-host "New-Timespan";
    new-timespan $begin $end;
    write-host "timespan $begin $end";

    write-host " ";
    write-host "End of Script - chef_client_install_14.7.17.ps1";
    ### End of powershell script chef_client_install_xx_xx_xx.ps1;
}
}
