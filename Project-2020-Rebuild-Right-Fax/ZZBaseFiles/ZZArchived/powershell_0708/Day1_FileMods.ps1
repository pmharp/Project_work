
# Perform the Terraform functions to build out devices defined in the initial _Build_terraform folder
# Designed to 
# .  ./Day1_FileMods.ps1 -makeFiles   Builds Files based on count and type
# .  ./Day1_FileMods.ps1 -modTF       Replace all IDs and Groups
# .  ./Day1_FileMods.ps1 -modS3       Replace S3 values in main.tf
# .  ./Day1_FileMods.ps1 -UAT         For UAT, preset tfvars and local storage Used
# .  ./Day1_FileMods.ps1 -resetAll    Reset all files back to initial day0 step
# 

param (
    [switch]$makeFiles = $false,
    [switch]$modTF = $false,
    [switch]$modS3 = $false,
    [switch]$UAT = $false,
    [switch]$resetAll = $false
)

$RSO_Array = @(
    # This controls all the file builds, questions and replacements
    # Prompt, BaseFilename minus the _1.tf, BuildCount (filled in by user)
    # Item0=Question to User, Item1=RSO_File_Name, Item2=FileLocationUnderZZBasefile\
    ('Linux (Rhel8, Rhel7 and CentOS) vms to build - ODI: ' ,'linux_odi', 'Day1Work\Day1_InitialBuilds' ),
    ('Windows (2019 and 2016) vms to build - ODI: ' ,'windows_odi', 'Day1Work\Day1_InitialBuilds' ),
    ('Apache vms to build - vRa: ' ,'apache', 'Day1Work\Day1_InitialBuilds' ),
    ('JBoss vms to build - vRa: ' ,'jboss', 'Day1Work\Day1_InitialBuilds' ),
    ('Rhel 6 FS vms to build - vRa: ' ,'rhel6_fs', 'Day1Work\Day1_InitialBuilds' ),
    ('Rhel 7 FS vms to build - vRa: ' ,'rhel7_fs', 'Day1Work\Day1_InitialBuilds' ),
    ('Standalone mySQL vms to build - vRa: ' ,'mysql', 'Day1Work\Day1_InitialBuilds' ),
    ('Win2012R2 FS vms to build - vRa: ' ,'win2012_fs', 'Day1Work\Day1_InitialBuilds' ),  
    ('Win2016 FS vms to build - vRa: ' ,'win2016_fs', 'Day1Work\Day1_InitialBuilds' ),
    ('Win2019 FS vms to build - vRa: ' ,'win2019_fs', 'Day1Work\Day1_InitialBuilds' ),
    ('Standalone msSQL on Win12R2 vms to build - vRa: ' ,'mssql_win12r2', 'Day1Work\Day1_InitialBuilds' ),
    ('DNS Aliases to build: ' ,'net_dns_alias', 'OtherProviders' ),
    ('GTM w/ 2 LTMs to build: ' ,'net_gtm2ltms', 'OtherProviders' ),
    ('LTMs-load balancers to build: ' ,'net_ltm_only', 'OtherProviders' ),
    ('NAS mounts to build: ' ,'nas_nas', 'OtherProviders' )
)

function SanityChecks {
    # IMPORTANT - This Function in BOTH Day1_FileMods.ps1 and Day1_Orchectration.ps1
    # Did not make cross sciprt subcalls due to ps runs main code as well as specific function   

    # Make sure folders exist first
    if (!(Test-Path '..\Day1_InitialBuilds' )) {  Invoke-Expression "./Day0_InitialSetup.ps1 -day1" }

    # Support for chefdk - depricated while new chef workstation is directional
    if (Test-Path 'C:\opscode\chef-workstation\embedded\bin\sed.exe')   { $installedChefClient =  "chef-workstation" }
    elseif  (Test-Path 'C:\opscode\chefdk\embedded\bin\sed.exe')  { $installedChefClient =  "chefdk" }
    else  { $installedChefClient =  "UNKNOWN" }

    # Determine optumvm provider to use and update main.tf, Use highest version it finds
    if (Test-Path 'C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm_*.exe' ) { $optumVM_Pvdr = "  host = ""https://infra-apis.optum.com""" }
    elseif (Test-Path 'C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm.exe') { $optumVM_Pvdr = "  host = ""https://paasapi.optum.com""" }
    else { $optumVM_Pvdr = "  host = ""UNKNOWN PROVIDER""" }

    # BEGIN OPTUMVM provider modification within main.tf
    # Remove code for all optumVM provider specific items in main.tf
    set-location "../Day1_InitialBuilds"
    Get-childItem  -Recurse -Filter main.tf | % {
        (Get-Content $_.FullName) `
        | where { (($_ -notmatch "# host") -and ($_ -notmatch "version") -and ($_ -notmatch "infra-apis") -and ($_ -notmatch "##")) } `
        | Set-Content $_.FullName
    }

    # Add correct lines back in
    $lines = Get-Content main.tf
    $pos = [array]::indexof($lines, $lines -match "insecure = true") 
    $newLines = $lines[0..($pos)], $optumVM_Pvdr, $lines[($pos + 1)..($lines.Length - 1)]
    $newLines | Set-Content main.tf
    set-location "../powershell"
    # END OPTUMVM provider modification within main.tf
}

function BuildFiles {
    param ($RSO, $RSO_Cnt, $RSOFolderLocation)

    # Set the base file name for all copies of the delete
    $RSOBaseFileName = $RSO + "_0"

    # Support for chefdk - depricated while new chef workstation is directional
    if (Test-Path 'C:\opscode\chef-workstation\embedded\bin\sed.exe')   { $installedChefClient =  "chef-workstation" }
    elseif  (Test-Path 'C:\opscode\chefdk\embedded\bin\sed.exe')  { $installedChefClient =  "chefdk" }
    else  { $installedChefClient =  "UNKNOWN" }

    if ($RSO_Cnt -gt 0)
    {
        # Replicate the base file how many times is requested and change the headings
        For ($i=1; $i -le $RSO_Cnt; $i++) {
            $RSONewFileName = $RSO + "_" + $i
            set-location "../Day1_InitialBuilds"
            
            # Only add new files to RSO count, leave existing files alone could be manually modded (cpu/ram)
            if (-Not (Test-Path "${RSONewFileName}.tf" )) {
                Copy-Item -Path "..\ZZBaseFiles\${RSOFolderLocation}\${RSOBaseFileName}.tf"  -Destination "..\Day1_InitialBuilds\${RSONewFileName}.tf" -Container
                $sed_replace_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/${RSOBaseFileName}/${RSONewFileName}/g' ${RSONewFileName}.tf"
                Invoke-Expression $sed_replace_cmd
            }
        }
    }
}

if ($makeFiles){

    SanityChecks
    set-location "../Day1_InitialBuilds"
    $RSOs_Needed = 0

    
    echo "`r`n--------READ Questions Carefully before answering---------" 
    echo "----Numbers entered are NET value, Use 0 for no increase-----`r`n" 
    
    # Loop through RSO_Aray and process questions
    foreach($item in $RSO_Array)
    {
        $RSOs_Needed = Read-Host -Prompt $item[0]
        BuildFiles -RSO $item[1] -RSO_Cnt $RSOs_Needed -RSOFolderLocation $item[2]
    }
    echo "`r`n.TF files created, ready for next step or rerun to adjust counts`r`n" 
    set-location "../powershell"
}
elseif ($modTF){

    #  Need sanity checks and check for if this was already run 
    SanityChecks

    # Support for chefdk - depricated while new chef workstation is directional
    if (Test-Path 'C:\opscode\chef-workstation\embedded\bin\sed.exe')   { $installedChefClient =  "chef-workstation" }
    elseif  (Test-Path 'C:\opscode\chefdk\embedded\bin\sed.exe')  { $installedChefClient =  "chefdk" }
    else  { $installedChefClient =  "UNKNOWN" }

    # Get values from user and builds commands
    echo "`r`n--------READ Questions Carefully before answering---------" 
    echo "----CASE Matters (IDs lower, Group how it shows in AD-----`r`n" 
    $w_pri_usr_id = Read-Host -Prompt 'Primary Windows MS ID (Requested for)'
    $w_sec_usr_id = Read-Host -Prompt 'Secondary Windows AD ID (Windows Admin)'
    $w_ark_grd_id = Read-Host -Prompt 'AD Privileged Group Name (Windows Admin)'
    $l_sec_usr_id = Read-Host -Prompt 'Secondary UNIX ID (Linux Admin)'

    # Make sure all IDs are in lowercase
    $w_pri_usr_id = $w_pri_usr_id.ToLower()
    $w_sec_usr_id = $w_sec_usr_id.ToLower()
    $l_sec_usr_id = $l_sec_usr_id.ToLower()
    
    # Look to determine where SED is installed - Currenlty this is on all laptop and vdi with chef installed
    $sed_pri_MSID_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/PRIMSID/$w_pri_usr_id/g' terraform.tfvars"
    $sed_sec_MSID_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/2NDADID/$w_sec_usr_id/g' terraform.tfvars"
    $sed_ARK_GRPID_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/ADPRIVILEGEDGG/$w_ark_grd_id/g' terraform.tfvars"
    $sed_sec_unixID_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/2NDUNIXID/$l_sec_usr_id/g' terraform.tfvars"
    $edit_tfvars_cmd = "code terraform.tfvars" 

    # run the commands
    set-location "../Day1_InitialBuilds"
    Invoke-Expression $sed_pri_MSID_cmd
    Invoke-Expression $sed_sec_MSID_cmd
    Invoke-Expression $sed_ARK_GRPID_cmd
    Invoke-Expression $sed_sec_unixID_cmd
    invoke-expression $edit_tfvars_cmd
    echo "`r`nTerraform files have been modified successfuly, Terraform.tfvars file in VSC terminal for MANAUL editting`r`n" 
    set-location "../powershell"
}
elseif ($modS3){

    #  Need sanity checks and check for if this was already run 
    SanityChecks

    # Support for chefdk - depricated while new chef workstation is directional
    if (Test-Path 'C:\opscode\chef-workstation\embedded\bin\sed.exe')   { $installedChefClient =  "chef-workstation" }
    elseif  (Test-Path 'C:\opscode\chefdk\embedded\bin\sed.exe')  { $installedChefClient =  "chefdk" }
    else  { $installedChefClient =  "UNKNOWN" }

    # Get values from user and builds commands
    echo "`r`n--------READ Questions Carefully before answering---------`r`n"  
    $s3_endpoint = Read-Host -Prompt 'S3 Endpoint url Core = s3api-core.uhc.com  DMZ = s3api-dmz.uhc.com'
    $s3_bucket = Read-Host -Prompt 'S3 Bucket Name (Use Project Number i.e. prj999999)'
    $s3_key = Read-Host -Prompt 'S3 full path for tfstate file (ex: env/dc)'
    $s3_access_key_id = Read-Host -Prompt 'S3 Access Key ID'
    $s3_secret_access_key = Read-Host -Prompt 'S3 Secret Access Key'

    # Make sure all IDs are in lowercase
    $s3_endpoint = $s3_endpoint.ToLower()
    $s3_bucket = $s3_bucket.ToLower()
    $s3_key = $s3_key.ToLower() + "/terraform.tfstate"

    echo "`r`nConfiguring AWS Local Profile for $s3_bucket....."
    aws configure set aws_access_key_id $s3_access_key_id --profile $s3_bucket
    aws configure set aws_secret_access_key $s3_secret_access_key --profile $s3_bucket
    aws configure set output json --profile $s3_bucket
    echo "Configuration of profile for $s3_bucket complete"
    
    # Look to determine where SED is installed - Currently this is on all laptop and vdi with chef installed
    #  The # is used for replacements when "/" is in the actaul variable value
    $sed_s3_endpoint_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/S3_ENDPOINT/${s3_endpoint}/g' main.tf"
    $sed_s3_bucket_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/S3_BUCKET/${s3_bucket}/g' main.tf"
    $sed_s3_key_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's#S3_KEY_PATH#${s3_key}#g' main.tf"
    $sed_s3_access_key_id_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/S3_ACCESS_KEY/${s3_access_key_id}/g' main.tf"
    $sed_s3_secret_access_key_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/S3_SECRET_KEY/${s3_secret_access_key}/g' main.tf"

    # run the commands
    set-location "../Day1_InitialBuilds"
    Invoke-Expression $sed_s3_endpoint_cmd
    Invoke-Expression $sed_s3_bucket_cmd
    Invoke-Expression $sed_s3_key_cmd
    Invoke-Expression $sed_s3_access_key_id_cmd
    Invoke-Expression $sed_s3_secret_access_key_cmd
    
    terraform init -input=false
    write-host -nonewline "Confirm the S3 backend was configured successfully with no errors. Enter (Y) if successful and continue , enter (N) to re-run S3 setup: "
    $response = read-host
    if ( $response -ne "Y" ) { 
        if (Test-Path '..\Day1_InitialBuilds\.terraform' ) { Remove-Item '..\Day1_InitialBuilds\.terraform' -Recurse }
        Copy-Item -Path "..\ZZBaseFiles\Day1Work\Day1_InitialBuilds\main.tf"  -Recurse -Destination "..\Day1_InitialBuilds" -Container
        echo "`r`nTerraform S3 setup was unsuccessful, please re-run ./Day1_FileMods.ps1 -ModS3 with correct values" 
        set-location "../powershell"
        exit 
    }
    else {
        if (Test-Path '..\Day1_InitialBuilds\.terraform' ) { Remove-Item '..\Day1_InitialBuilds\.terraform' -Recurse }
        echo "`r`nMain.tf has been modified successfuly for S3.  Ready for next step" 
        set-location "../powershell"
    }
}
elseif ( $UAT ) {
    # Reset main.tf and terraform,tfvars to UAT prefilled versions
    if (Test-Path '..\Day1_InitialBuilds\main.tf' ) { Remove-Item '..\Day1_InitialBuilds\main.tf' -Force }
    if (Test-Path '..\Day1_InitialBuilds\terraform.tfvars' ) { Remove-Item '..\Day1_InitialBuilds\terraform.tfvars' -Force }
    Copy-Item -Path "..\ZZBaseFiles\UAT_Work\main.tf" -Destination "..\Day1_InitialBuilds\" -Container 
    Copy-Item -Path "..\ZZBaseFiles\UAT_Work\terraform.tfvars" -Destination "..\Day1_InitialBuilds\" -Container 

    # Create needed UAT test files and then update values for the requester
    Invoke-Expression "./Day1_FileMods.ps1 -Makefiles"
    Invoke-Expression "./Day1_FileMods.ps1 -ModTF"
    echo "`r`nAll Scripting done and configured, ready to begin provisioning process`r`n" 
}
elseif ( $resetAll ) { 
    # Day 1 reset
    if (Test-Path '..\Day1_InitialBuilds' ) { Remove-Item '..\Day1_InitialBuilds' -Recurse  -Force }
    if (Test-Path '..\Day1_inspec' ) { Remove-Item '..\Day1_inspec' -Recurse  -Force }
    Copy-Item -Path "..\ZZBaseFiles\Day1Work\Day1_InitialBuilds"  -Recurse -Destination "..\" -Container 
    if (Test-Path '..\Day1_InitialBuilds\*_0.tf' ) { Remove-Item '..\Day1_InitialBuilds\*_0.tf' -Recurse  -Force }
    Copy-Item -Path "..\ZZBaseFiles\Day1Work\Day1_inspec"  -Recurse -Destination "..\" -Container 
    # # Day 2 reset if exists
    # if (Test-Path '..\Day2_Filesystems' ) { 
    #     Remove-Item '..\Day2_Filesystems' -Recurse  -Force 
    #     Copy-Item -Path "..\ZZBaseFiles\Day2Work\Day2_Filesystems"  -Recurse -Destination "..\" -Container 
    # }
    # if (Test-Path '..\Day2_Inspec' ) { 
    #     Remove-Item '..\Day2_Inspec' -Recurse  -Force 
    #     Copy-Item -Path "..\ZZBaseFiles\Day2Work\Day2_Inspec"  -Recurse -Destination "..\" -Container
    # }
}
else {
    echo "`r`n--------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo " ./Day1_FileMods.ps1 -makeFiles  Builds Files based on count and type"
    echo " ./Day1_FileMods.ps1 -modTF      Replace all IDs and Groups"
    echo " ./Day1_FileMods.ps1 -modS3      Replace all S3 values in main.tf"
    echo " ./Day1_FileMods.ps1 -UAT        For UAT, preset tfvars and local storage Used"
    echo " ./Day1_FileMods.ps1 -resetAll   reset all files back to initial day0 step"
    echo "--------------------------------------------------------------------------`r`n" 
}