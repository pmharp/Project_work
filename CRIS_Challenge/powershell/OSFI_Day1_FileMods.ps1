
# Perform the Terraform functions to build out devices defined in the initial _Build_terraform folder
# Designed to 
# .  ./OSFI_Day1_FileMods.ps1 -makeFiles   Builds Files based on count and type
# .  ./OSFI_Day1_FileMods.ps1 -modTF       Replace all IDs and Groups
# .  ./OSFI_Day1_FileMods.ps1 -modS3       Replace S3 values in main.tf
# .  ./OSFI_Day1_FileMods.ps1 -resetAll    Reset all files back to initial day0 step
# 

param (
    [switch]$makeFiles = $false,
    [switch]$modTF = $false,
    [switch]$modS3 = $false,
    [switch]$resetAll = $false
)

$RSO_Array = @(
    # This controls all the file builds, questions and replacements
    # Prompt, BaseFilename minus the _1.tf, BuildCount (filled in by user)
    # Item0=Question to User, Item1=RSO_File_Name, Item2=FileLocationUnderZZBasefile\
    ('Deployments to build: ' ,'deployment', 'Day1Work\OSFI_InitialBuilds' ),
    ('Services to build: ' ,'service', 'Day1Work\OSFI_InitialBuilds' ),
    ('NetworkPolicy to build: ' ,'networkpolicy', 'Day1Work\OSFI_InitialBuilds' )
)

function SanityChecks {
    # IMPORTANT - This Function in BOTH OSFI_Day1_FileMods.ps1 and Day1_Orchectration.ps1
    # Did not make cross script subcalls due to ps runs main code as well as specific function   
    # Make sure folders exist first
    if (!(Test-Path '..\OSFI_InitialBuilds' )) {  Invoke-Expression "./OSFI_Day0_InitialSetup.ps1 -day1" }
}

function BuildFiles {
    param ($RSO, $RSO_Cnt, $RSOFolderLocation)

    # Set the base file name for all copies of the delete
    $RSOBaseFileName = $RSO + "_0"

    if ($RSO_Cnt -gt 0)
    {
        # Replicate the base file how many times is requested and change the headings
        For ($i=1; $i -le $RSO_Cnt; $i++) {
            $RSONewFileName = $RSO + "_" + $i
            set-location "../OSFI_InitialBuilds"
                        
            # Support for chefdk - depricated while new chef workstation is directional
            if  (Test-Path 'C:\opscode\chefdk\embedded\bin\sed.exe')  { $installedChefClient =  "chefdk" }
            elseif (Test-Path 'C:\opscode\chef-workstation\embedded\bin\sed.exe')   { $installedChefClient =  "chef-workstation" }
            else  { $installedChefClient =  "UNKNOWN" }
            
            # Only add new files to RSO count, leave existing files alone could be manually modded (cpu/ram)
            if (-Not (Test-Path "${RSONewFileName}.tf" )) {
                Copy-Item -Path "..\ZZBaseFiles\${RSOFolderLocation}\${RSOBaseFileName}.tf"  -Destination "..\OSFI_InitialBuilds\${RSONewFileName}.tf" -Container

                # This is case sensistive syntax
                $sed_replace_cmd = "C:\opscode\${installedChefClient}\embedded\bin\sed -i 's/${RSOBaseFileName}/${RSONewFileName}/g' ${RSONewFileName}.tf"
                Invoke-Expression $sed_replace_cmd
            }
        }
    }
}

if ($makeFiles){

    SanityChecks
    set-location "../OSFI_InitialBuilds"
    # Set to 1 since we are not mature in this space yet, otherwise set to 0
    $RSOs_Needed = 1

    # Uncomment with need user inout again
    # echo "`r`n--------READ Questions Carefully before answering---------" 
    # echo "----Numbers entered are NET value, Use 0 for no increase-----`r`n" 
    
    # Loop through RSO_Aray and process questions
    foreach($item in $RSO_Array)
    {
        # Uncomment with need user inout again
        # $RSOs_Needed = Read-Host -Prompt $item[0]
        BuildFiles -RSO $item[1] -RSO_Cnt $RSOs_Needed -RSOFolderLocation $item[2]
    }
    echo "`r`n.TF files created, ready for next step`r`n" 
    set-location "../powershell"
}
elseif ($modTF){

    #  Need sanity checks and check for if this was already run 
    SanityChecks

    # Look to determine where SED is installed - Currenlty this is on all laptop and vdi with chef installed
    $edit_tfvars_cmd = "code terraform.tfvars" 
    

    # run the commands
    set-location "../OSFI_InitialBuilds"
    invoke-expression $edit_tfvars_cmd
    echo "`r`nTerraform files have been modified successfuly, Terraform.tfvars file in VSC terminal for MANAUL editting`r`n" 
    set-location "../powershell"
}
elseif ($modS3){

    #  Need sanity checks and check for if this was already run 
    SanityChecks

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
    $sed_s3_endpoint_cmd = "C:\opscode\chefdk\embedded\bin\sed -i 's/S3_ENDPOINT/${s3_endpoint}/g' main.tf"
    $sed_s3_bucket_cmd = "C:\opscode\chefdk\embedded\bin\sed -i 's/S3_BUCKET/${s3_bucket}/g' main.tf"
    $sed_s3_key_cmd = "C:\opscode\chefdk\embedded\bin\sed -i 's#S3_KEY_PATH#${s3_key}#g' main.tf"
    $sed_s3_access_key_id_cmd = "C:\opscode\chefdk\embedded\bin\sed -i 's/S3_ACCESS_KEY/${s3_access_key_id}/g' main.tf"
    $sed_s3_secret_access_key_cmd = "C:\opscode\chefdk\embedded\bin\sed -i 's/S3_SECRET_KEY/${s3_secret_access_key}/g' main.tf"

    # run the commands
    set-location "../OSFI_InitialBuilds"
    Invoke-Expression $sed_s3_endpoint_cmd
    Invoke-Expression $sed_s3_bucket_cmd
    Invoke-Expression $sed_s3_key_cmd
    Invoke-Expression $sed_s3_access_key_id_cmd
    Invoke-Expression $sed_s3_secret_access_key_cmd
    
    terraform init -input=false
    write-host -nonewline "Confirm the S3 backend was configured successfully with no errors. Enter (Y) if successful and continue , enter (N) to re-run S3 setup: "
    $response = read-host
    if ( $response -ne "Y" ) { 
        if (Test-Path '..\OSFI_InitialBuilds\.terraform' ) { Remove-Item '..\OSFI_InitialBuilds\.terraform' -Recurse }
        Copy-Item -Path "..\ZZBaseFiles\Day1Work\OSFI_InitialBuilds\main.tf"  -Recurse -Destination "..\OSFI_InitialBuilds" -Container
        echo "`r`nTerraform S3 setup was unsuccessful, please re-run ./OSFI_Day1_FileMods.ps1 -ModS3 with correct values" 
        set-location "../powershell"
        exit 
    }
    else {
        if (Test-Path '..\OSFI_InitialBuilds\.terraform' ) { Remove-Item '..\OSFI_InitialBuilds\.terraform' -Recurse }
        echo "`r`nMain.tf has been modified successfuly for S3.  Ready for next step" 
        set-location "../powershell"
    }
}
elseif ( $resetAll ) { 
    # Day 1 reset
    if (Test-Path '..\OSFI_InitialBuilds' ) { Remove-Item '..\OSFI_InitialBuilds' -Recurse  -Force }
    Copy-Item -Path "..\ZZBaseFiles\Day1Work\OSFI_InitialBuilds"  -Recurse -Destination "..\" -Container 
    if (Test-Path '..\OSFI_InitialBuilds\*_0.tf' ) { Remove-Item '..\OSFI_InitialBuilds\*_0.tf' -Recurse  -Force }
}
else {
    echo "`r`n--------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo " ./OSFI_Day1_FileMods.ps1 -makeFiles  Builds Files based on count and type"
    echo " ./OSFI_Day1_FileMods.ps1 -modTF      Replace all IDs and Groups"
    echo " ./OSFI_Day1_FileMods.ps1 -modS3      Replace all S3 values in main.tf"
    echo " ./OSFI_Day1_FileMods.ps1 -resetAll   reset all files back to initial day0 step"
    echo "--------------------------------------------------------------------------`r`n" 
}