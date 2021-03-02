
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

function setowner {
    param($svrShortName, $newOwner, $OutputType, $OutputFileName)

    $ForegroundColor = "Green"
    $Log_Status = "Initial_Value"
    $HdrFtrSpacing = "-----------------------------------------------------------------------------"

    $requestBody = @{"requestedFor"="$script:w_usr_id";  "serverName"="$svrShortName"; "resourceAction"="changeowner"; "newOwner"="$newOwner"; "vraEnv"="prod"} | ConvertTo-Json
    $request = Invoke-RestMethod -Method 'Post' -Uri $apiHost/api/vm/v8/vmday2action/?sync=true -Body $requestBody -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $script:apiToken"}
    $uuid = $request.uuid
    do{
        Start-Sleep -Seconds 1.5
        if ($log){
            $Log_Status = "Performing getResourceData/$uuid GET API request"
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
            write-host ($Log_Status)
        }
        $resourceData = Invoke-RestMethod -Method 'GET' -Uri $apiHost/api/async/task/$uuid -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $script:apiToken"}  
    }
    until ($resourceData.taskState -eq "FINISHED")
    
    $processOutput = $resourceData.processOutput | ConvertTo-Json | ConvertFrom-Json

    if ($processOutput.type -eq "SUCCESS"){
        $ForegroundColor = "Green"
        $Log_Status = "${svrShortName} owned by ${newOwner}"
    }
    else {
        $ForegroundColor = "Yellow"
        $ErrorMsg = $processOutput.message
        $Log_Status = "Failed to change Ownership on server ${svrShortName} to ${newOwner}`r`nREASON: ${ErrorMsg}"
    }
    
    # Determine where to write output to based on input type
    if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
    write-host ($Log_Status) -ForegroundColor $ForegroundColor
}
# End Function block-----------------------------------

# Begin Program Logic-----------------------------------
if ( $kb ) { 
    fnsPreFlightWork
    $svrShortName = Read-Host -Prompt 'Enter Server ShortName'
    $newOwner = Read-Host -Prompt "New Server Owner's vRa ID (msid)"
    setowner -svrShortName $svrShortName -newOwner $newOwner -OutputType "Screen" -OutputFileName ""
}
elseif ( ($list -and ($screen -or $file)) ) {
    fnsPreFlightWork
    $newOwner = Read-Host -Prompt "New Server Owner's vRa ID (msid)"
    $InputFileName = "E:\SC\Rightfax-Kiosk\Owner\_InputList_Servers.txt"
    $RunDateTime = (Get-Date -Format "yyyy_MM_dd_HHmmtt") 
    $OutputFileName = "LogFiles/odisetowner_${RunDateTime}.txt"
    
    write-host ("`r`n----- Process Starting -----`r`n") -ForegroundColor "Yellow"
    if ($file) {
        if (-Not (Test-Path "LogFiles" )) { $NotToScreen = New-Item -ItemType Directory -Force -Path "LogFiles" }
        if (Test-Path $OutputFileName) { write-host ("`r`n**** ${OutputFileName} exists, erasing current content data for new run****`r`n") -ForegroundColor "Yellow" }
        Out-File -FilePath $OutputFileName
        $headerText = "Beginning Set Owner Run on " +  $RunDateTime
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
            if ($screen) {  setowner -svrShortName $svr -newOwner $newOwner -OutputType "Screen" -OutputFileName "" }
            elseif ($file) {  setowner -svrShortName $svr -newOwner $newOwner -OutputType "File" -OutputFileName $OutputFileName }
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
    write-host "`r`n--------------------------------------------------------------------------------------"  -ForegroundColor "Yellow"
    write-host "Expires-> ${apiToken_exp}`r`n" -ForegroundColor "Green"
    write-host "ID->      ${apiToken}" -ForegroundColor "Green"
    write-host "--------------------------------------------------------------------------------------`r`n"   -ForegroundColor "Yellow"
}
else {
    write-host "`r`n---------------------------------------------------------------------------------------------------------------------------------" 
    write-host "                         NO PARAMETER SPECIFIED" 
    write-host "  ./odi_setowner.ps1 -kb                 keyboard input results sent to screen"
    write-host "  ./odi_setowner.ps1 -kb -log            Logging, keyboard input results sent to screen"
    write-host "  ./odi_setowner.ps1 -list -screen       Pull servers from _InputList_Servers.txt, results sent to screen"
    write-host "  ./odi_setowner.ps1 -list -screen -log  Logging, Pull servers from _InputList_Servers.txt, results sent to screen"
    write-host "  ./odi_setowner.ps1 -list -file         Pull servers from _InputList_Servers.txt, results sent setsharedaccess_.txt"
    write-host "  ./odi_setowner.ps1 -list -file -log    Logging, Pull servers from _InputList_Servers.txt, results sent setsharedaccess_....txt"
    write-host "  ./odi_setowner.ps1 -token              Returns the token and expiration date pulled from the login"
    write-host "---------------------------------------------------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------