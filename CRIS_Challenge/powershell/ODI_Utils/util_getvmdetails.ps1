
# powershell command to get all server assigned to a user, ODI (v8) but its data is from servicenow

# Designed to 
# .  ./util_getvmdetails.ps1 -kb                   keyboard input results sent to screen
# .  ./util_getvmdetails.ps1 -kb -log              Logging and keyboard input results sent to screen
# .  ./util_getvmdetails.ps1 -list -screen         Pull servers from ServerList.txt, results sent to screen
# .  ./util_getvmdetails.ps1 -list -screen -log    Logging and Pull servers from ServerList.txt, results sent to screen
# .  ./util_getvmdetails.ps1 -list -file           Pull servers from ServerList.txt, results sent getvmdetails_.....txt
# .  ./util_getvmdetails.ps1 -list -file  -log     Logging and Pull servers from ServerList.txt, results sent getvmdetails_.....txt

param (
    [switch]$kb = $false,
    [switch]$list = $false,
    [switch]$screen = $false,
    [switch]$file = $false,
    [switch]$log = $false
)


# Begin Variable block - Initializing--------------
# All Form Variables for calls
$apiHost = "https://infra-apis.optum.com"
$contentType = "application/json"
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
# End Variable block-----------------------------------

# Begin Function Logic-----------------------------------
function getvmdetails {
    param($servername,  $OutputType, $OutputFileName)


    $ForegroundColor = "Green"
    $Log_Status = "Initial_Value"
    $HdrFtrSpacing = "-----------------------------------------------------------------------------"
    
    # BodyParts Variables
    $vraEnv ="PROD"     # Options are DEV, TEST, STAGE, PROD

    $requestBody = @{"serverName"="$servername";  "vraEnv"="$vraEnv"} | ConvertTo-Json
    $request = Invoke-RestMethod -Method 'Post' -Uri $apiHost/api/vm/v8/getvmdetails/?sync=true -Body $requestBody -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"}
    $uuid = $request.uuid
    do{
        Start-Sleep -Seconds 5
        if ($log){
            $Log_Status = "Performing getResourceData/$uuid GET API request"
            write-host ($Log_Status)
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
        }
        $resourceData = Invoke-RestMethod -Method 'GET' -Uri $apiHost/api/async/task/$uuid -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"}   
    }
    until ($resourceData.taskState -eq "FINISHED")
    
    $processOutput = $resourceData.processOutput | ConvertTo-Json | ConvertFrom-Json
    if ($processOutput.type -eq "SUCCESS"){
        $ForegroundColor = "Green"
        $Log_Status = "got the details for server: ${servername}"
        if ($OutputType -eq "File") {  
            Add-Content $OutputFileName $HdrFtrSpacing 
            Add-Content $OutputFileName $Log_Status 
            Add-Content $OutputFileName $HdrFtrSpacing 
        }
        write-host ($HdrFtrSpacing) -ForegroundColor $ForegroundColor
        write-host ($Log_Status) -ForegroundColor $ForegroundColor
        write-host ($HdrFtrSpacing) -ForegroundColor $ForegroundColor

        # Display entire message block in name/value pair columns
        $messageInJSON = $processOutput.message | ConvertFrom-Json 
        $messageInJSON
        if ($OutputType -eq "File") {  
            Add-Content $OutputFileName $messageInJSON  
            Add-Content $OutputFileName $HdrFtrSpacing 
        }
        write-host ($HdrFtrSpacing) -ForegroundColor "Green"
    }
    else {
        $ForegroundColor = "Red"
        $Log_Status = $processOutput.message +"`r`n" + "Failed to get details for server: ${servername}"
        if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
        write-host ($Log_Status) -ForegroundColor $ForegroundColor
    }
}

function fnsPreFlightWork{
    # This will gather the msid and mspassword from the host and authenticate to the api and retrieve the token
    # NOTE - as of now, this does not check for expired token or if it is still valid 
    echo "`r`n"
    write-host "--------Gathering Preflight Data------------"    
    echo "`r`n"
    $script:msid = Read-Host "Enter your MSID"
    $script:mspassword = Read-Host "Enter your MSID Password" -AsSecureString
    $script:mspassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($script:mspassword))
    $body = @{"username"="$msid"; "password"="$script:mspassword"} | ConvertTo-Json
    try{
        if ($log){
            Write-Host "Performing API Authentication - retrieving token"
        }
        $authentication = Invoke-RestMethod -Method 'Post' -Uri $apiHost/auth/login -Body $body -ContentType $contentType
    }
    catch {
        if ($log){
            Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__
        }
        Write-Host "There was a problem logging into the API" -ForegroundColor Red
        exit
    }
    $script:apiToken = $authentication.access_token
}

# End Function block-----------------------------------

# Begin Program Logic-----------------------------------

if ( $kb ) { 

    fnsPreFlightWork
    $servername = Read-Host -Prompt 'Enter servername'
    getvmdetails -servername $servername -OutputType "Screen" -OutputFileName ""
}
elseif ( ($list -and ($screen -or $file)) ) {

    fnsPreFlightWork
    $InputFileName = "ServerList.txt"
    $RunDateTime = (Get-Date -Format "yyyy_MM_dd_HHmmtt") 
    $OutputFileName = "LogFiles/getvmdetails_${RunDateTime}.txt"

    if ($file) {
        if (Test-Path $OutputFileName) {
            write-host ("`r`n**** ${OutputFileName} exists, erasing current content data for new run****`r`n") -ForegroundColor "Yellow"
        }
        write-host ("`r`n----- Process Starting -----`r`n") -ForegroundColor "Yellow"
        Out-File -FilePath $OutputFileName
        $headerText = "Beginning UserServerList Run on " +  $RunDateTime
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
            if ($screen) {  getvmdetails -servername $svr -OutputType "Screen" -OutputFileName "" }
            elseif ($file) {  getvmdetails -servername $svr -OutputType "File" -OutputFileName $OutputFileName }
            else {  write-host ("`r`n**** Unknown output parameter ****`r`n") -ForegroundColor "Red" }
        }
        write-host ("`r`n----- Process Completed -----`r`n") -ForegroundColor "Yellow"
    }
    else {
        write-host ("`r`n**** ServerList.txt does NOT EXIST in current directory ****`r`n") -ForegroundColor "Red"
        exit
    }
}
else {
    echo "`r`n--------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "  ./util_getvmdetails.ps1 -kb                   keyboard input results sent to screen"
    echo "  ./util_getvmdetails.ps1 -kb -log              Logging and keyboard input results sent to screen"
    echo "  ./util_getvmdetails.ps1 -list -screen         Pull servers from ServerList.txt, results sent to screen"
    echo "  ./util_getvmdetails.ps1 -list -screen -log    Logging and Pull servers from ServerList.txt, results sent to screen"
    echo "  ./util_getvmdetails.ps1 -list -file           Pull servers from ServerList.txt, results sent SvrDetail.txt"
    echo "  ./util_getvmdetails.ps1 -list -file  -log     Logging and Pull servers from ServerList.txt, results sent SvrDetail.txt"
    echo "--------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------