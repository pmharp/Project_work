
# Designed to 
# .  ./util_iacChecks.ps1 -listAll       Lists providers that it will pull from github
# .  ./util_iacChecks.ps1 -pullGA        Pull specific versions of the TF providers
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
$OptumVM_Version = "v3.1.1"             # GA version
$OptumVM_UAT_Version = "v3.2.0"         # UAT
$OptumVM_UAT_Branch = "development"          # Branch to pull from

$OptumNas_Version = "v1.0.2"            # GA version
$OptumNas_UAT_Version = "v1.0.2"        # UAT
$OptumNas_UAT_Branch = "v1.0.2"         # Branch to pull from

$OptumSecure_Version = "v1.0.1"         # GA version
$OptumSecure_UAT_Version = "v1.0.1"     # UAT
$OptumSecure_UAT_Branch = "v1.0.1"      # Branch to pull from

$OptumStorage_Version = "v1.0.0"         # GA version
$OptumStorage_UAT_Version = "v1.0.0"     # UAT
$OptumStorage_UAT_Branch = "v1.0.0"      # Branch to pull from

$OptumNetwork_Version = "v2.2.0"        # GA version
$OptumNetwork_UAT_Version = "v2.2.0"    # UAT
$OptumNetwork_UAT_Branch = "v2.2.0"     # Branch to pull from
# -----------------------------------------------------

$Optum_Pvdr_UAT_Array = @(
     # Item0=PvdrName, Item1=UATversion, Item2=GAVersion, Item3=guthubURI, Item4=guthubURI
     ("     OptumVM",${OptumVM_UAT_Version},${OptumVM_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumvm/raw/${OptumVM_UAT_Branch}/bin/windows/terraform-provider-optumvm_${OptumVM_UAT_Version}.exe", "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm_${OptumVM_UAT_Version}.exe"),
     ("    OptumNAS",${OptumNas_UAT_Version},${OptumNas_Version},"https://github.optum.com/IAC-COE/terraform-provider-nas/raw/${OptumNas_UAT_Branch}/bin/windows/terraform-provider-optumnas_${OptumNas_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumnas_${OptumNas_UAT_Version}.exe"),
     (" OptumSecure",${OptumSecure_UAT_Version},${OptumSecure_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumsecure/raw/${OptumSecure_UAT_Branch}/bin/windows/terraform-provider-optumsecure_${OptumSecure_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumsecure_${OptumSecure_UAT_Version}.exe"),
     (" OptumStorage",${OptumStorage_UAT_Version},${OptumStorage_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumstorage/raw/${OptumStorage_UAT_Branch}/bin/windows/terraform-provider-optumstorage_${OptumStorage_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumstorage_${OptumStorage_UAT_Version}.exe"),
     ("OptumNetwork",${OptumNetwork_UAT_Version},${OptumNetwork_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumnetwork/raw/${OptumNetwork_UAT_Branch}/bin/windows/terraform-provider-optumnetwork_${OptumNetwork_UAT_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumnetwork_${OptumNetwork_UAT_Version}.exe")

)

$Optum_Pvdr_Array = @(
    # Item0=PvdrName, Item1=UATversion(null), Item2=GAVersion, Item3=guthubURI, Item4=guthubURI
    # ("OptumVM","",${OptumVM_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumvm/raw/${OptumVM_Version}/bin/windows/terraform-provider-optumvm.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm.exe"),
    ("OptumVM","",${OptumVM_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumvm/raw/${OptumVM_Version}/bin/windows/terraform-provider-optumvm_${OptumVM_Version}.exe", "C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumvm_${OptumVM_Version}.exe"),
    ("OptumNAS","",${OptumNAS_Version},"https://github.optum.com/IAC-COE/terraform-provider-nas/raw/${OptumNas_Version}/bin/windows/terraform-provider-optumnas_${OptumNas_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumnas_${OptumNas_Version}.exe"),
    ("OptumSecure","",${OptumSecure_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumsecure/raw/${OptumSecure_Version}/bin/windows/terraform-provider-optumsecure_${OptumSecure_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumsecure_${OptumSecure_Version}.exe"),
    ("OptumStorage","",${OptumStorage_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumstorage/raw/${OptumStorage_Version}/bin/windows/terraform-provider-optumstorage_${OptumStorage_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumstorage_${OptumStorage_Version}.exe"),
    ("OptumNetwork","",${OptumNetwork_Version},"https://github.optum.com/IAC-COE/terraform-provider-optumnetwork/raw/${OptumNetwork_Version}/bin/windows/terraform-provider-optumnetwork_${OptumNetwork_Version}.exe","C:\Program Files\UnitedHealth Group\Terraform\terraform-provider-optumnetwork_${OptumNetwork_Version}.exe")

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
    echo "`r`n---- GA and UAT Versions pulled by script ----`r`n"
    foreach($item in $Optum_Pvdr_UAT_Array)  {
        $MsgtoScreen = $item[0] + ", GA-" + $item[2] + ", UAT-" + $item[1] + "`r`n"
        write-host $MsgtoScreen
    }
    echo "---------------------------------------------`r`n"
}
elseif ( $pullGA ) { 
    ResetProviders -target "SrcDst"
    foreach($item in $Optum_Pvdr_Array)  {
        $MsgtoScreen = "Pulling GA - " + $item[0] + ", " + $item[2] + "........"
        write-host $MsgtoScreen
        (New-Object System.Net.WebClient).DownloadFile($item[3], $item[4])
    }
    ResetProviders -target "Src"
}
elseif ( $pullUAT ) { 
    ResetProviders -target "SrcDst"
    foreach($itemUAT in $Optum_Pvdr_UAT_Array)  {
        $MsgtoScreen = "Pulling UAT - " + $itemUAT[0] + ", " + $itemUAT[1] + "........"
        write-host $MsgtoScreen
        (New-Object System.Net.WebClient).DownloadFile($itemUAT[3], $itemUAT[4])
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
    echo "./util_iacChecks.ps1 -pullGA        Pull specific versions of the TF providers"
    echo "./util_iacChecks.ps1 -pullUAT       Pulls UAT provider candidates for testing"
    echo "./util_iacChecks.ps1 -validateIAC   Validates ALL IAC software setup correctly"
    echo "./util_iacChecks.ps1 -validateVDI   Validates software to build out VMs, GTM/LTMs and NAS"
    echo "./util_iacChecks.ps1 -validateOSFI  Validates software to build out containers in K8s and OKD"
    echo "---------------------------------------------------------------------------------------------`r`n" 
}
# End parameters main guardrail logic-----------------------------------