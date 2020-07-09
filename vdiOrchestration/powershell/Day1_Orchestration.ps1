# Perform the Terraform functions to build out devices defined in the Day1_initialBuilds folder
# Make the json file for inspec from the terraform state file
# Create the server based inspec tests in the staged folder by server name


# Designed to 
# .  ./Day1_Orchestration.ps1 -RunTF       Run the Terraform builds
# .  ./Day1_Orchestration.ps1 -inspec      Create the inspec control files by server
# .  ./Day1_Orchestration.ps1 -Realign     Realigns provider endpoints with providers installed
# 

param (
    [switch]$runTF = $false,
    [switch]$inspec = $false,
    [switch]$realign = $false
)

# ---BEGIN FNS---------------------------------------------
function SanityChecks {
    # IMPORTANT - This Function in BOTH Day1_FileMods.ps1 and Day1_Orchectration.ps1
    # Did not make cross sciprt subcalls due to ps runs main code as well as specific function   

    # Make sure folders exist first
    if (!(Test-Path '..\Day1_InitialBuilds' )) {  Invoke-Expression "./Day0_InitialSetup.ps1 -day1" }

    # Determine optumvm provider to use and update main.tf, Use highest version it finds
    if (Test-Path 'C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm_*.exe' ) { $optumVM_Pvdr = "  host = ""https://infra-apis.optum.com""" }
    elseif (Test-Path 'C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm.exe') { $optumVM_Pvdr = "  host = ""https://paasapi.optum.com""" }
    else { $optumVM_Pvdr = "  host = ""UNKNOWN PROVIDER""" }

    # BEGIN OPTUMVM provider modification within main.tf
    # Remove code for all optumVM provider specific items in main.tf
    set-location "../Day1_InitialBuilds"
    Get-childItem  -Recurse -Filter main.tf | % {
        (Get-Content $_.FullName) `
        | where { (($_ -notmatch "host") -and ($_ -notmatch "version") -and ($_ -notmatch "infra-apis") -and ($_ -notmatch "##")) } `
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

function DetermineServerType {
    param ($ServerShortName, $TargetEnv, $Software)

    $inspecTemplateName = ''
    $ServerFns = $ServerShortName.substring(0,2).ToLower()
    $ServerType = $ServerShortName.substring(2,1).ToLower()
    $ServerOS = $ServerShortName.substring(3,1).ToLower()
    # Coded but will use the targetEnv from the statefile as a pass in
    # $ServerEnv = $ServeShortName.substring(4,1)  

    # Check for Rhel and then narrow to find apache or jboss
    if ($ServerOS -eq 'r') { 
        if ($Software -eq 'apach') {
            $inspecTemplateName = "day1_Apache_Server" 
        }
        elseif ($Software -eq 'jboss') {
            $inspecTemplateName = "day1_jboss_Server" 
        }
        else {
            $inspecTemplateName = "day1_Rhel_Server" 
        }
    }
    
    # Check for windows
    elseif  ($ServerOS -eq 'e') { $inspecTemplateName = "day1_Windows_server" }
    
    # Assign as unknown for the rb file
    else { $inspecTemplateName = "day1_zzUnknown_server" }

    # Return template to copy for the server
    return $inspecTemplateName
}
# ---END FNS-----------------------------------------------


# ---START THE PROGRAM-------------------------------------
# the Build out of all the servers
if ( $RunTF ) { 
    $w_usr_id = Read-Host -Prompt 'Primary Windows MS ID'
    $w_usr_pwd = Read-Host -Prompt 'Primary Windows MS Password' -AsSecureString
    $w_Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $w_usr_id, $w_usr_pwd
    $w_extract_pwd = $w_Credentials.GetNetworkCredential().Password
    $tfPlan = "terraform plan -var 'PriMsId=${w_usr_id}' -var 'PriMsIdPwd=${w_extract_pwd}'"
    $tfApply = "terraform apply -var 'PriMsId=${w_usr_id}' -var 'PriMsIdPwd=${w_extract_pwd}' -auto-approve"

    set-location "../Day1_InitialBuilds"
    terraform init -input=false
    terraform -v
    Invoke-Expression $tfPlan

    write-host -nonewline "Confirm Terraform plan above. Would you like to Continue? (Y/N) "
    $response = read-host
    if ( $response -ne "Y" ) { 
        set-location "../powershell"
        exit 
    }
    else {
        Invoke-Expression $tfApply
        set-location "../powershell"
    }
}
elseif ($inspec) {
    # Resets powershell from UTF16 to ASCII to aid inspec in reading in json files without errors
    $PSDefaultParameterValues['*:Encoding'] = 'ascii'
    $JSON_FullPath = '..\Day1_inspec\test\day1\files\terraform.json'
    
    set-location "../Day1_InitialBuilds"
    # Making sure all is ready to do work
    if (Test-Path $JSON_FullPath ) { Remove-Item $JSON_FullPath -Recurse } 
    if (! (Test-Path '.terraform' )) { terraform init -input=false } 
    if (! (Test-Path '..\Day1_inspec\test\day1\controls' )) { New-Item -ItemType Directory -Force -Path '..\Day1_inspec\test\day1\controls' } 
    if (! (Test-Path '..\Day1_inspec\test\day1\files' )) { New-Item -ItemType Directory -Force -Path '..\Day1_inspec\test\day1\files' } 
    if (! (Test-Path '..\Day1_inspec\test\day1\files\staged' )) { New-Item -ItemType Directory -Force -Path '..\Day1_inspec\test\day1\files\staged' } 
    if (! (Test-Path '..\Day1_inspec\test\day1\reports' )) { New-Item -ItemType Directory -Force -Path '..\Day1_inspec\test\day1\reports' } 

    # Builds the json file in UTF8, but with CRLF
    terraform output --json > $JSON_FullPath

    # Reads in file and removes the "carriage return" leaving only the LF to allow inspec to read in without errors
    (Get-Content $JSON_FullPath) -replace "[`r`n']+, ' '" -join "`n" |  Set-Content -NoNewline $JSON_FullPath
    if (Test-Path $JSON_FullPath ) { echo "`r`nterraform.json built successfully in inspec\test\day1\files folder" }

    # Builds the inspec control files from the TF json file and the inspec templates
    Invoke-Expression 'clear'
    $JSON_FullPath = '..\Day1_inspec\test\day1\files\terraform.json'
    $json = Get-Content $JSON_FullPath -Raw -Encoding UTF8 | ConvertFrom-Json

    echo "`r`nFiles building in \files\staged\:"
    foreach($object_properties in $json.psobject.properties)
    {
        if ($object_properties.Name -like "*servername")
        {
            $TemplateToCopy = ''
            $ParentOutputVarName = $object_properties.Name.substring(0, $object_properties.Name.Length - 10)
            $RecipeTargetFullPath = '..\Day1_inspec\test\day1\files\staged\' + $object_properties.Value.value + '.rb'
            # Pull first 5 characters of the output name to see if it is apache or jboss to set the right inspec template
            $SoftwareLen5 = $object_properties.Name.substring(0, 5)

            # Replace placeholders with appropiate values in each specific server.RB file
            # All output vars must start with same text up until "servername"
            $TemplateToCopy = DetermineServerType -ServerShortName $object_properties.Value.value -Software $SoftwareLen5
            Copy-Item -Path "..\Day1_inspec\templates\$TemplateToCopy.rb" -Destination $RecipeTargetFullPath -Container


            (Get-Content $RecipeTargetFullPath) | ForEach-Object {$_ -Replace 'TF_OUTPUT_RESOURCE_NAME-', $ParentOutputVarName} | Set-Content $RecipeTargetFullPath

            if (Test-Path $RecipeTargetFullPath) {
                $SuccessFile  = $object_properties.Value.value + '.rb'
                echo $SuccessFile
            }
        } 
    }
    set-location "../powershell"
    echo "`r`n"
}
elseif ($realign) {

    # Cross script does not work because ps also runs main part of program  after the function call
    # need to make sure day1_filemods is in same folder
    # This tells PS to run the Sanity checks function located within Day1_FileMods script here
    # . ./Day1_FileMods.ps1

    #  Local Fucntion call now
    SanityChecks

}
else {
    echo "`r`n-----------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo " ./Day1_Orchestration.ps1 -RunTF    Run the Terraform builds"
    echo " ./Day1_Orchestration.ps1 -inspec   Create the inspec control files by server"
    echo " ./Day1_Orchestration.ps1 -Realign  Realigns provider endpoints with providers installed"
    echo "-----------------------------------------------------------------------------------------`r`n" 
}
# --END THE PROGRAM----------------------------------------