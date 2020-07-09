# Perform the Terraform functions to build out devices defined in the Day1_initialBuilds folder
# Make the json file for inspec from the terraform state file
# Create the server based inspec tests in the staged folder by server name


# Designed to 
# .  ./Day1_Orchestration.ps1 -RunTF       Run the Terraform builds
# 

param (
    [switch]$runTF = $false
)

# ---BEGIN FNS---------------------------------------------

# ---END FNS-----------------------------------------------


# ---START THE PROGRAM-------------------------------------
# the Build out of all the servers
if ( $RunTF ) { 
    $tfPlan = "terraform plan"
    $tfApply = "terraform apply -input=false -auto-approve"

    set-location "../OSFI_InitialBuilds"
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
else {
    echo "`r`n-----------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo " ./Day1_Orchestration.ps1 -RunTF    Run the Terraform builds"
    echo "-----------------------------------------------------------------------------------------`r`n" 
}
# --END THE PROGRAM----------------------------------------