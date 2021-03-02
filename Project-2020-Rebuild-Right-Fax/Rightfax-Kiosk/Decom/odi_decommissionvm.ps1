
param (
    [switch]$kb = $false,
    [switch]$list = $false,
    [switch]$screen = $false,
    [switch]$file = $false,
    [switch]$log = $false,
    [switch]$token = $false
)

# Begin Variable block - Initializing--------------
# All Form Variables for calls
$apiHost = "https://infra-apis.optum.com"
$contentType = "application/json"
$AllProtocols = [System.Net.SecurityProtocolType]'Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
# End Variable block-----------------------------------

# Begin Function Logic-----------------------------------

function fnsPreFlightWork{
    # This will gather the w_usr_id and w_usr_pwd from the host and authenticate to the api and retrieve the token
    # NOTE - as of now, this does not check for expired token or if it is still valid 
    write-host "`r`n--------Gathering Preflight Data------------`r`n"    
    $w_usr_id = Read-Host "Enter your MSID"
    $w_usr_pwd = Read-Host "Enter your MSID Password" -AsSecureString
    # $w_Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $w_usr_id, $w_usr_pwd
    # $w_usr_pwd = $w_Credentials.GetNetworkCredential().Password

    if ($IsWindows -or $ENV:OS) {  $w_usr_pwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($w_usr_pwd)) } 
    elseif ($IsMacos) { $w_usr_pwd = ConvertFrom-SecureString -SecureString $w_usr_pwd -AsPlainText }
    else { }

    $body = @{"username"="$w_usr_id"; "password"="$w_usr_pwd"} | ConvertTo-Json
    try{
        if ($log){ Write-Host "Performing API Authentication - retrieving token" -ForegroundColor Blue }
        $authentication = Invoke-RestMethod -Method 'Post' -Uri $apiHost/auth/login -Body $body -ContentType $contentType
    }
    catch {
        if ($log){ Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__ -ForegroundColor Blue }
        Write-Host "There was a problem logging into the API" -ForegroundColor Red
        exit
    }
    $script:apiToken = $authentication.access_token
    $script:w_usr_id = $w_usr_id
    $script:w_usr_pwd = $w_usr_pwd
}

function v8decommisionvm {
    param($servername,  $OutputType, $OutputFileName)

    $ForegroundColor = "Green"
    $Decomm_Status = "Initial_Value"

    # BodyParts Variables
    $vraEnv ="PROD"     # Options are DEV, TEST, STAGE, PROD

    $requestBody = @{"serverName"="$servername";  "vraEnv"="$vraEnv"} | ConvertTo-Json
    $request = Invoke-RestMethod -Method 'Post' -Uri $apiHost/api/vm/v8/decommissionvm/?sync=true -Body $requestBody -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"}
    $uuid = $request.uuid
    do{
        Start-Sleep -Seconds 5
        if ($log){
            $Decomm_Status = "Performing getResourceData/$uuid GET API request"
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Decomm_Status  }
            write-host ($Decomm_Status) -ForegroundColor Blue
        }
        $resourceData = Invoke-RestMethod -Method 'GET' -Uri $apiHost/api/async/task/$uuid -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"}   
    }
    until ($resourceData.taskState -eq "FINISHED")
    
    $processOutput = $resourceData.processOutput | ConvertTo-Json | ConvertFrom-Json
    if ($processOutput.type -eq "SUCCESS"){
        $ForegroundColor = "Green"
        $Decomm_Status = "${servername} submitted for Decomm"
    }
    else {
        $ForegroundColor = "Yellow"
        $Decomm_Status = $processOutput.message +"`r`n" + "Failed to submit Decomm on server ${servername}"
    }
    
    # Determine where to write output to based on input type
    if ($OutputType -eq "File") {  Add-Content $OutputFileName $Decomm_Status  }
    write-host ($Decomm_Status) -ForegroundColor $ForegroundColor
}
# End Function block-----------------------------------

# Begin Program Logic-----------------------------------
if ( $kb ) { 

    fnsPreFlightWork
    $servername = Read-Host -Prompt 'Enter Server ShortName'
    v8decommisionvm -servername $servername -OutputType "Screen" -OutputFileName ""
}
elseif ( ($list -and ($screen -or $file)) ) {

    fnsPreFlightWork
    $InputFileName = "E:\SC\Rightfax-Kiosk\Decom\_InputList_Servers.txt"
    $RunDateTime = (Get-Date -Format "yyyy_MM_dd_HHmmtt") 
    $OutputFileName = "LogFiles/v8decommisionvm_${RunDateTime}.txt"


    write-host ("`r`n----- Process Starting -----`r`n") -ForegroundColor "Yellow"
    if ($file) {
        if (-Not (Test-Path "LogFiles" )) { $NotToScreen = New-Item -ItemType Directory -Force -Path "LogFiles" }
        if (Test-Path $OutputFileName) { write-host ("`r`n**** ${OutputFileName} exists, erasing current content data for new run****`r`n") -ForegroundColor "Yellow" }
        Out-File -FilePath $OutputFileName
        $headerText = "Beginning Decomm Run on " +  $RunDateTime
        Add-Content $OutputFileName $headerText
    }

    if (Test-Path $InputFileName)  { 
        # Get file content, remove blank lines and edit data for shortnames
        # create array to loop through and remove any empty lines
        $InputFileContents = Get-Content($InputFileName)
        $InputFileContents = $InputFileContents | ? {$_}
        $InputFileContents = $InputFileContents.replace(".ms.ds.uhc.com","").replace(".uhc.com","")
        $tmpContentArray = $InputFileContents.split(",",[System.StringSplitOptions]::RemoveEmptyEntries)

        #  Looping through all the items in the file
        foreach ($svr in $tmpContentArray) {
            if ($screen) {  v8decommisionvm -servername $svr -OutputType "Screen" -OutputFileName "" }
            elseif ($file) {  v8decommisionvm -servername $svr -OutputType "File" -OutputFileName $OutputFileName }
            else {  write-host ("`r`n**** Unknown output parameter ****`r`n") -ForegroundColor "Yellow" }
        }
        write-host ("`r`n----- Process Completed -----`r`n") -ForegroundColor "Yellow"
    }
    else {
        write-host ("`r`n**** _InputList_Servers.txt does NOT EXIST in current directory ****`r`n") -ForegroundColor "Yellow"
        exit
    }
}
elseif ( $token ) {

    fnsPreFlightWork
    write-host "`r`n----------------------------------------------------------------------------------------------------------------------"  -ForegroundColor "Yellow"
    write-host "Swagger Inferface where the token was generated from: https://infra-apis.optum.com/login`r`n"
    write-host "Token-> ${apiToken}`r`n" -ForegroundColor "Green"
    write-host "Swagger Inferface for infra-apis: https://infra-apis.optum.com/swagger-ui.html#/Compute"
    write-host "----------------------------------------------------------------------------------------------------------------------`r`n"   -ForegroundColor "Yellow"
}
else {
    write-host "`r`n-------------------------------------------------------------------------------------------------------------------------------------" 
    write-host "                         NO PARAMETER SPECIFIED" 
    write-host "  ./odi_decommissionvm.ps1 -kb                 keyboard input results sent to screen"
    write-host "  ./odi_decommissionvm.ps1 -kb -log            Logging, keyboard input results sent to screen"
    write-host "  ./odi_decommissionvm.ps1 -list -screen       Pull servers from _InputList_Servers.txt, results sent to screen"
    write-host "  ./odi_decommissionvm.ps1 -list -screen -log  Logging, Pull servers from _InputList_Servers.txt, results sent to screen"
    write-host "  ./odi_decommissionvm.ps1 -list -file         Pull servers from _InputList_Servers.txt, results sent v8decommisionvm_...txt"
    write-host "  ./odi_decommissionvm.ps1 -list -file -log    Logging, Pull servers from _InputList_Servers.txt, results sent v8decommisionvm_...txt"
    write-host "  ./odi_decommissionvm.ps1 -token              Returns the token pulled from the login"
    write-host "-------------------------------------------------------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------