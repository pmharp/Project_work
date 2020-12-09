
# Designed to 
# .  ./util_iacChecks.ps1 -listAll       Lists providers that it will pull from github
# .  ./util_iacChecks.ps1 -pullGA        Pull Latest versions of the TF providers
# .  ./util_iacChecks.ps1 -pullUAT       Pulls UAT provider candidates for testing
# .  ./util_iacChecks.ps1 -validateIAC   Validates ALL IAC software setup correctly
# .  ./util_iacChecks.ps1 -validateVDI   Validates software to build out VMs, GTM/LTMs and NAS
# .  ./util_iacChecks.ps1 -validateOSFI  Validates software to build out container in K8s and OKD

param (
    [switch]$listAll = $false,
    [switch]$pullGA = $false,
    [switch]$pullUAT = $false,
    [switch]$validateIAC = $false,
    [switch]$validateVDI = $false,
    [switch]$validateOSFI = $false
)

# Begin Variable block - Initializing--------------
### UAT VERSIONS - Need to manually modify as branches and versions are changes by developers
# -----------------------------------------------------
$OptumVM_UAT_Version = "v3.3.0"         # UAT
$OptumVM_UAT_Branch = "development"          # UAT Branch to pull from

$OptumSecure_UAT_Version = "v1.0.1"     # UAT
$OptumSecure_UAT_Branch = "v1.0.1"      # UAT Branch to pull from

$OptumStorage_UAT_Version = "v1.0.0"     # UAT
$OptumStorage_UAT_Branch = "v1.0.0"      # UAT Branch to pull from

$OptumNetwork_UAT_Version = "v2.2.1"    # UAT
$OptumNetwork_UAT_Branch = "v2.2.1"     # UAT Branch to pull from

# Deprecatied, all FNS rolled into OptumStorage provider above
# $OptumNas_UAT_Version = "v1.0.2"        # UAT
# $OptumNas_UAT_Branch = "v1.0.2"         # UAT Branch to pull from

# -----------------------------------------------------

$Optum_Pvdr_UAT_Array = @(
     # Item0=PvdrName, Item1=UATversion, Item2=guthubURI, Item3=InstallFullPath
     ("     OptumVM",${OptumVM_UAT_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumvm/raw/${OptumVM_UAT_Branch}/bin/windows/terraform-provider-optumvm_${OptumVM_UAT_Version}.exe", "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm_${OptumVM_UAT_Version}.exe"),
     (" OptumSecure",${OptumSecure_UAT_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumsecure/raw/${OptumSecure_UAT_Branch}/bin/windows/terraform-provider-optumsecure_${OptumSecure_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumsecure_${OptumSecure_UAT_Version}.exe"),
     ("OptumStorage",${OptumStorage_UAT_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumstorage/raw/${OptumStorage_UAT_Branch}/bin/windows/terraform-provider-optumstorage_${OptumStorage_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumstorage_${OptumStorage_UAT_Version}.exe"),
     ("OptumNetwork",${OptumNetwork_UAT_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumnetwork/raw/${OptumNetwork_UAT_Branch}/bin/windows/terraform-provider-optumnetwork_${OptumNetwork_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumnetwork_${OptumNetwork_UAT_Version}.exe")
  #  ("    OptumNAS",${OptumNas_UAT_Version},"https://github.optum.com/IAC-COE/terraform-provider-nas/raw/${OptumNas_UAT_Branch}/bin/windows/terraform-provider-optumnas_${OptumNas_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumnas_${OptumNas_UAT_Version}.exe"),
)

$Optum_Pvdr_Array = @(
    # Item0=PvdrName, Item1=guthubURI, Item2=InstallFullPath, Item3=git_RepoNameAndFileName
    ("OptumVM","https://github.optum.com/IAC-COE/terraform-provider-optumvm/raw/", "C:\Program Files\UnitedHealth Group\Terraform\","terraform-provider-optumvm"),
    ("OptumSecure","https://github.optum.com/IAC-COE/terraform-provider-optumsecure/raw/","C:\Program Files\UnitedHealth Group\Terraform\","terraform-provider-optumsecure"),
    ("OptumStorage","https://github.optum.com/IAC-COE/terraform-provider-optumstorage/raw/","C:\Program Files\UnitedHealth Group\Terraform\","terraform-provider-optumstorage"),
    ("OptumNetwork","https://github.optum.com/IAC-COE/terraform-provider-optumnetwork/raw/","C:\Program Files\UnitedHealth Group\Terraform\","terraform-provider-optumnetwork")
  # ("OptumNAS","https://github.optum.com/IAC-COE/terraform-provider-nas/raw/","C:\Program Files\UnitedHealth Group\Terraform\","terraform-provider-nas"),
)
# End Variable block - Initializing--------------


# Begin Function Logic-----------------------------------
function ResetProviders {
    # Remove from downloads and default terraform location
    param ($target)   # options are "src", "Dst" or "SrcDst"

    if ($target -eq "Src") {
        if (Test-Path "C:\users\$env:UserName\Downloads\terraform-provider*.exe" ) {  Remove-Item "C:\users\$env:UserName\Downloads\terraform-provider*.exe" -Recurse  -Force }
    }
    elseif ($target -eq "Dst") {
        if (Test-Path "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider*.exe" ) {  Remove-Item "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider*.exe" -Recurse  -Force }
    }
    else  {
        if (Test-Path "C:\users\$env:UserName\Downloads\terraform-provider*.exe" ) {  Remove-Item "C:\users\$env:UserName\Downloads\terraform-provider*.exe" -Recurse  -Force }
        if (Test-Path "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider*.exe" ) {  Remove-Item "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider*.exe" -Recurse  -Force }
    }
}
# End Function Logic-----------------------------------

# Begin parameters main guardrail logic-----------------------------------
if ( $listAll ) { 
    echo "`r`n---- Latest Tagged version to be pulled by script ----`r`n"
    foreach($item in $Optum_Pvdr_Array)  {
        # pull all the tagged versions and then parse through to get the last one
        $invokeCommand = "git ls-remote --tags --refs --sort='v:refname' https://github.optum.com/IAC-COE/" + $item[3]
        $CommandResult = invoke-expression $invokeCommand
        $CommandResult = $CommandResult.split('/')
        $Latest_Tagged_Version = $CommandResult[$CommandResult.length-1]
        $MsgtoScreen = $item[0] + ", GA-" + $Latest_Tagged_Version + " ---> " + $item[0] + "_" + $Latest_Tagged_Version + ".exe`r`n"
        write-host $MsgtoScreen
    }
    echo "------------------------------------------------------`r`n"
}
elseif ( $pullGA ) { 
    ResetProviders -target "SrcDst"
    foreach($item in $Optum_Pvdr_Array)  {
        # pull all the tagged versions and then parse through to get the last one
        $invokeCommand = "git ls-remote --tags --refs --sort='v:refname' https://github.optum.com/IAC-COE/" + $item[3]
        $CommandResult = invoke-expression $invokeCommand
        $CommandResult = $CommandResult.split('/')
        $Latest_Tagged_Version = $CommandResult[$CommandResult.length-1]
        $gitLastest = $item[1] + "/" + $Latest_Tagged_Version + "/bin/windows/" + $item[3] + "_" + $Latest_Tagged_Version + ".exe"
        $HardDrvLatest = $item[2] + $item[3] + "_" + $Latest_Tagged_Version + ".exe"
        $MsgtoScreen = "Pulling GA - " + $item[0] + ", " +  $Latest_Tagged_Version + "........"
        write-host $MsgtoScreen
        (New-Object System.Net.WebClient).DownloadFile($gitLastest, $HardDrvLatest)
    }
    ResetProviders -target "Src"
}
elseif ( $pullUAT ) { 
    ResetProviders -target "SrcDst"
    foreach($itemUAT in $Optum_Pvdr_UAT_Array)  {
        $MsgtoScreen = "Pulling UAT - " + $itemUAT[0] + ", " + $itemUAT[1] + "........"
        write-host $MsgtoScreen
        (New-Object System.Net.WebClient).DownloadFile($itemUAT[2], $itemUAT[3])
    }
    ResetProviders -target "Src"
}
elseif ( $validateIAC ) { 
    echo "`r`n------------------------------------------------------------------"
    echo "Validating ALL IAC Software:  ......Please standby........."
    echo "------------------------------------------------------------------`r`n"
    inspec exec https://github.optum.com/IAC-COE/IaC_EndUser_Inspec/archive/master.zip
}
elseif ( $validateVDI ) { 
    echo "`r`n------------------------------------------------------------------"
    echo "Validating VDI Specific Software:  ......Please standby........."
    echo "------------------------------------------------------------------`r`n"
    inspec exec https://github.optum.com/IAC-COE/IaC_EndUser_Inspec/archive/master_VDI.zip
}
elseif ( $validateOSFI ) { 
    echo "`r`n--------------------------------------------------------------------"
    echo "Validating OSFI Specific Software:   ......Please standby........."
    echo "--------------------------------------------------------------------`r`n"
    inspec exec https://github.optum.com/IAC-COE/IaC_EndUser_Inspec/archive/master_OSFI.zip
}
else {
    echo "`r`n---------------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "./util_iacChecks.ps1 -listAll       Lists providers that it will pull from github"
    echo "./util_iacChecks.ps1 -pullGA        Pull Latest versions of the TF providers"
    echo "./util_iacChecks.ps1 -pullUAT       Pulls UAT provider candidates for testing"
    echo "./util_iacChecks.ps1 -validateIAC   Validates ALL IAC software setup correctly"
    echo "./util_iacChecks.ps1 -validateVDI   Validates software to build out VMs, GTM/LTMs and NAS"
    echo "./util_iacChecks.ps1 -validateOSFI  Validates software to build out containers in K8s and OKD"
    echo "---------------------------------------------------------------------------------------------`r`n" 
}
# End parameters main guardrail logic-----------------------------------