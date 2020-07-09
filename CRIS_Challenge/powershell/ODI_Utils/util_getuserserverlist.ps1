
# powershell command to get all server assigned to a user, ODI (v8) but its data is from servicenow

# Designed to 
# .  ./util_getuserserverlist.ps1 -kb                   keyboard input results sent to screen
# .  ./util_getuserserverlist.ps1 -kb -log              Logging and keyboard input results sent to screen
# .  ./util_getuserserverlist.ps1 -list -screen         Pull servers from UserList.txt, results sent to screen
# .  ./util_getuserserverlist.ps1 -list -screen -log    Logging and Pull servers from UserList.txt, results sent to screen
# .  ./util_getuserserverlist.ps1 -list -file           Pull servers from UserList.txt, results sent getuserlserverlist_.....txt
# .  ./util_getuserserverlist.ps1 -list -file  -log     Logging and Pull servers from UserList.txt, results sent getuserlserverlist_.....txt

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
function getuserlserverlist {
    param($ownerId,  $OutputType, $OutputFileName)

    $ForegroundColor = "Green"
    $Log_Status = "Initial_Value"
    $HdrFtrSpacing = "-----------------------------------------------------------------------------"

    # BodyParts Variables
    $offset          ="all"     # Options are all
    $size            ="all"     # Options are all
    $serverNamesOnly = ""       # Options are "", "yes"
    $vraEnv          ="PROD"    # Options are DEV, TEST, STAGE, PROD

    $requestBody = @{"offset"="$offset"; "ownerId"="$ownerId"; "size"="$size"; "vraEnv"="$vraEnv"} | ConvertTo-Json
    $request = Invoke-RestMethod -Method 'Post' -Uri $apiHost/api/vm/v8/getuserserverlist/?sync=true -Body $requestBody -Headers @{"Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"}
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

        #Pull out the data and total servers
        $message = $processOutput.message | ConvertFrom-Json
        $total_count = $message.total_count  | ConvertFrom-Json

        if ($total_count -gt 200) {
            # How to use Offset for later coding
            #   if number of servers owned by user = 220
            #   offset = all, size = all, will get 200 servers in response along with the server count = 220
            #   user can then get the remaining 20 servers using offset=2, size=200
            $ForegroundColor = "yellow"
            $Log_Status = "WARNING *** ID owns more than 200 servers - Need to mod code to get FULL LIST ***"
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
            write-host ($Log_Status) -ForegroundColor $ForegroundColor
        }

        $ForegroundColor = "Green"
        $Log_Status = "Retrieved list of $total_count servers for ${ownerId}"
        if ($OutputType -eq "File") {  
            Add-Content $OutputFileName $HdrFtrSpacing 
            Add-Content $OutputFileName $Log_Status 
            Add-Content $OutputFileName $HdrFtrSpacing 
        }
        write-host ($HdrFtrSpacing) -ForegroundColor $ForegroundColor
        write-host ($Log_Status) -ForegroundColor $ForegroundColor
        write-host ($HdrFtrSpacing) -ForegroundColor $ForegroundColor
        
        $ServerListSortedArray = @()
        for ($i=0; $i -lt $message.data.length; $i++)  {
             $serverName = $message.data[$i].serverName
             $ServerListSortedArray +=   $message.data[$i]
        }
        
        $ServerListSortedArray = $ServerListSortedArray | Sort vmDateCreated -descending
        foreach ($item in $ServerListSortedArray) {
            $serverName = $item.serverName
            $ownersRef = $item.ownersRef
            $requestId = $item.requestId
            $status = $item.status
            $vmDateCreated = $item.vmDateCreated
            $Server_Status = "${serverName}, RequestID: ${requestId}, created: ${vmDateCreated}"
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Server_Status  }
            write-host ($Server_Status) -ForegroundColor "White"
        }

        if ($OutputType -eq "File") {  Add-Content $OutputFileName $HdrFtrSpacing   }
        write-host ($HdrFtrSpacing) -ForegroundColor "Green"
    }
    else {
        $ForegroundColor = "Red"
        $Log_Status = $processOutput.message +"`r`n" + "Failed to get list of servers for ${ownerId}"
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
    $ownerId = Read-Host -Prompt 'Enter ownerId'
    getuserlserverlist -ownerId $ownerId -OutputType "Screen" -OutputFileName ""
}
elseif ( ($list -and ($screen -or $file)) ) {

    fnsPreFlightWork
    $InputFileName = "UserList.txt"
    $RunDateTime = (Get-Date -Format "yyyy_MM_dd_HHmmtt") 
    $OutputFileName = "LogFiles/getuserlserverlist_${RunDateTime}.txt"

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
        foreach ($owner in $tmpContentArray) {
            if ($screen) {  getuserlserverlist -ownerId $owner -OutputType "Screen" -OutputFileName "" }
            elseif ($file) {  getuserlserverlist -ownerId $owner -OutputType "File" -OutputFileName $OutputFileName }
            else {  write-host ("`r`n**** Unknown output parameter ****`r`n") -ForegroundColor "Red" }
        }
        write-host ("`r`n----- Process Completed -----`r`n") -ForegroundColor "Yellow"
    }
    else {
        write-host ("`r`n**** UserList.txt does NOT EXIST in current directory ****`r`n") -ForegroundColor "Red"
        exit
    }
}
else {
    echo "`r`n--------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "  ./util_getuserserverlist.ps1 -kb                   keyboard input results sent to screen"
    echo "  ./util_getuserserverlist.ps1 -kb -log              Logging and keyboard input results sent to screen"
    echo "  ./util_getuserserverlist.ps1 -list -screen         Pull servers from UserList.txt, results sent to screen"
    echo "  ./util_getuserserverlist.ps1 -list -screen -log    Logging and Pull servers from UserList.txt, results sent to screen"
    echo "  ./util_getuserserverlist.ps1 -list -file           Pull servers from UserList.txt, results sent getuserlserverlist_....txt"
    echo "  ./util_getuserserverlist.ps1 -list -file  -log     Logging and Pull servers from UserList.txt, results sent getuserlserverlist_....txt"
    echo "--------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------