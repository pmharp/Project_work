
# Make the inspec ps1 file that will run against all servers defined by the statefile
# Needs to be run in VDI, runninglocally may give security access errors

# Designed to 
#.  ./Day1_RunInspecTests.ps1 -inspec      Runs the inspec by server - Saves output to S3
#.  ./Day1_RunInspecTests.ps1 -inspecUAT   Runs the inspec by server - Saves output locally
#

param (
    [switch]$inspec = $false,
    [switch]$inspecUAT = $false
)

# Array for server domains
$Serverdomains = @(
    (".ms.ds.uhc.com"),         # Core Windows domain
    (".uhc.com"),               # Core Linux domain
    (".dmzmgmt.uhc.com")        # DMZ dommain for windows and Linux
)

if ( $inspec -or $inspecUAT) {
    echo "`r`n------- Secondary RHEL/UNIX ID Credentials -------`r`n"
    $l_usr_id = Read-Host -Prompt 'Secondary UNIX ID'
    $l_usr_pwd = Read-Host -Prompt 'Secondary Unix Password' -AsSecureString
    $l_Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $l_usr_id, $l_usr_pwd
    $l_extract_pwd = $l_Credentials.GetNetworkCredential().Password

    echo "`r`n------- Secondary Active Directoy ID Credentials -------`r`n"
    $w_usr_id = Read-Host -Prompt 'Secondary Windows AD ID'
    $w_usr_pwd = Read-Host -Prompt 'Secondary Windows AD Password' -AsSecureString
    $w_Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $w_usr_id, $w_usr_pwd
    $w_extract_pwd = $w_Credentials.GetNetworkCredential().Password

    # Setup / Configure S3 for standard inspec testing
    #inspecUAT uses local storage already defined in their main.tf file
    if ( $inspec ) {
        #   --------------------  OLD CODE PRE-03/23
        # echo "`r`n-------------S3 Config for inspec reports -------------`r`n"
        # $s3_endpoint = Read-Host -Prompt 'S3 Endpoint url Core = s3api-core.uhc.com  DMZ = s3api-dmz.uhc.com'
        # $s3_bucket = Read-Host -Prompt 'S3 Bucket Name (Use Project Number i.e. prj999999)'
        # $s3_key = Read-Host -Prompt 'S3 full path for inspec files (ex: env/inspec/)'
        #   --------------------  OLD CODE PRE-03/23

        # Need to add spaces for key to work, look at doing spacing
        # ------------------------------------------------------------------
        . ./functions/SearchReplace.ps1
        $s3FindResult = Search_And_Replace_Text -search "endpoint                    =" -replace 'DISPLAY' -filename "../Day1_InitialBuilds/main.tf"
        $s3_endpoint =  $s3FindResult["value"].split("=").replace('"', "").replace(' ', "")[1]

        $s3FindResult = Search_And_Replace_Text -search "bucket                      =" -replace 'DISPLAY' -filename "../Day1_InitialBuilds/main.tf"
        $s3_bucket =  $s3FindResult["value"].split("=").replace('"', "").replace(' ', "")[1]

        $s3FindResult = Search_And_Replace_Text -search "key                         =" -replace 'DISPLAY' -filename "../Day1_InitialBuilds/main.tf"
        $s3_key =  $s3FindResult["value"].split("=").replace('"', "").replace(' ', "").replace("/terraform.tfstate","")[1]

        # Make sure all IDs are in lowercase
        $s3_endpoint = $s3_endpoint.ToLower()
        $s3_bucket = $s3_bucket.ToLower()
        $s3_key = $s3_key.ToLower()
        $s3_local_profile = $s3_bucket.ToLower()
        # We are now just saving the html reports to the reports folder under /Day1_inspec/test/day1/reports
        # $FullS3_cmd = "aws --endpoint https://${s3_endpoint} --no-verify-ssl --profile ${s3_local_profile} s3 cp day1\reports s3://${s3_bucket}/${s3_key}/inspec --recursive"    
    }    

    # get to right folder for file list and begin processing
    set-Location "..\Day1_inspec\test\day1\files\staged\"
    $DirFiles = Get-ChildItem *.rb 

    # get to test folder level to begin the process
    set-Location "..\..\..\"
    echo "`r`n"
    if (Test-Path "day1\controls\*.*" ) { Remove-Item "day1\controls\*.*" }
    if (Test-Path "day1\reports\*.*" ) { Remove-Item "day1\reports\*.*" }
    foreach($file in $DirFiles)
    {
        # copy file to controls folder
        $ServerName = $file.Name.substring(0,$file.Name.length-3)
        $ODIServer = $ServerName.substring(0,1).ToLower()
        $ServerOS = $ServerName.substring(3,1).ToLower()
        $StagedLocation = "day1\files\staged\" + $file.Name
        $DestinationLocation = "day1\controls\" + $file.Name
        $ServerReportNameExt = ${ServerName} + "_" + (Get-Date -Format "MM_dd_yyyy") + ".html"
    
        # Determine right domain the server is in
        foreach($dnsdomain in $Serverdomains)  {
            $TryingFQDN = ${ServerName} + ${dnsdomain}
            $validDomain = Resolve-DnsName -Name $TryingFQDN  -EA SilentlyContinue
            If($validDomain.Name -match $TryingFQDN) {
                $FoundFQDN = $TryingFQDN
                write-host ( "processing: ${FoundFQDN}")
            } 
        }
        Copy-Item -Path $StagedLocation -Destination $DestinationLocation 
            
        # run inspec against the server
        if ($ServerOS -eq 'r' -OR $ODIServer -eq 'c' -OR $ODIServer -eq 'r') { 
            # $FullInspec_cmd = "inspec exec day1 -t ssh://${l_usr_id}:${l_extract_pwd}@${FoundFQDN} --reporter html:day1\reports\${ServerReportNameExt}"
            $FullInspec_cmd = "inspec exec day1 --backend=ssh  --user=${l_usr_id} --password=${l_extract_pwd} --host=${FoundFQDN} --reporter html:day1\reports\${ServerReportNameExt}"
            Invoke-Expression $FullInspec_cmd
        }
        elseif  ($ServerOS -eq 'e' -OR $ODIServer -eq 'w') { 
            $FullInspec_cmd = "inspec exec day1 --backend=winrm --user=${w_usr_id} --password=${w_extract_pwd} --host=${FoundFQDN} --reporter html:day1\reports\${ServerReportNameExt}"
            Invoke-Expression $FullInspec_cmd
        }
        else { 
            write-host ( "Cannot Determine OS For server:-${FoundFQDN}")
        }

        # We are now just saving the html reports to the reports folder under /Day1_inspec/test/day1/reports
        # if ( $inspec ) { 
        #     Invoke-Expression $FullS3_cmd 
        #     if (Test-Path "day1\reports\*.*" ) { Remove-Item "day1\reports\*.*" }
        # }
        if (Test-Path "day1\controls\*.*" ) { Remove-Item "day1\controls\*.*" }
    }

    # Reset to the proper location 
    set-Location "..\..\powershell\"
    echo "`r`n"
}
else {
    echo "`r`n------------------------------------------------------------------------------------------" 
    echo "                                 NO PARAMETER SPECIFIED" 
    echo " ./Day1_RunInspecTests.ps1 -inspec      Runs the inspec by server - Saves output to S3"
    echo " ./Day1_RunInspecTests.ps1 -inspecUAT   Runs the inspec by server - Saves output locally"
    echo "------------------------------------------------------------------------------------------`r`n" 
}