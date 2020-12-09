
# powershell command to get all server assigned to a user, ODI (v8) but its data is from servicenow

# Designed to 
# .  ./util_getuserserverlist.ps1 -kb                   keyboard input results sent to screen
# .  ./util_getuserserverlist.ps1 -kb -log              Logging and keyboard input results sent to screen
# .  ./util_getuserserverlist.ps1 -list -screen         Pull servers from UserList.txt, results sent to screen
# .  ./util_getuserserverlist.ps1 -list -screen -log    Logging and Pull servers from UserList.txt, results sent to screen
# .  ./util_getuserserverlist.ps1 -list -file           Pull servers from UserList.txt, results sent getuserserverlist_.....txt
# .  ./util_getuserserverlist.ps1 -list -file  -log     Logging and Pull servers from UserList.txt, results sent getuserserverlist_.....txt

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
# $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
$AllProtocols = [System.Net.SecurityProtocolType]'Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols

# BodyParts Variables
$vraEnv          ="PROD"  # Options are DEV, TEST, STAGE, PROD (where all servers mainly built)
$offset          ="1"     # Page numbers - Options are 'all', integers that map to pages
$size            ="150"     # Number of servers per page - Options are 'all', integers that map to items per page
# $serverNamesOnly = ""     # Options are "", "yes"
# End Variable block-----------------------------------

# Begin Function Logic-----------------------------------

function fnsPreFlightWork{
    # This will gather the msid and mspassword from the host and authenticate to the api and retrieve the token
    # NOTE - as of now, this does not check for expired token or if it is still valid 
    write-host "`r`n--------Gathering Preflight Data------------`r`n"    
    $script:msid = Read-Host "Enter your MSID"
    $script:mspassword = Read-Host "Enter your MSID Password" -AsSecureString
    $script:mspassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($script:mspassword))
    $body = @{"username"="$msid"; "password"="$script:mspassword"} | ConvertTo-Json
    try{
        if ($log){ Write-Host "Performing API Authentication - retrieving token" -ForegroundColor Blue }
        $authentication = Invoke-RestMethod -Method 'Post' -Uri $apiHost/auth/login -Body $body -ContentType $contentType
    }
    catch {
        if ($log){ Write-Host "StatusCode:" $_.Exception.Response.StatusCode.value__  -ForegroundColor Blue }
        Write-Host "`r`nThere was a problem logging into the API`r`n" -ForegroundColor Red
        exit
    }
    # Store in working memory for rest of sript to access
    $script:apiToken = $authentication.access_token
}
function DoApiFnsCalls {
    param($ownerId, $vraEnv, $offset, $size, $FnsCall)
    # $Fnscall - Options are 1=Total servers Owned, 2=Return single page of servers in an Array 

    $requestBody = @{"ownerId"="$ownerId"; "vraEnv"="$vraEnv"; "offset"="$offset"; "size"="$size"} | ConvertTo-Json
    $requestHeader = @{"accept"="$contentType"; "Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"} 
    $asyncHeader = @{"Content-Type"="$contentType"; "Authorization"="Bearer $apiToken"} 

    # initial call to create job to begin pulling data get the UUID from the call, that is the job
    # Now need to make another call to see when the above reqeust /job is Finished, and use do until loop then pull return data from the job
    $request = Invoke-RestMethod -Method 'Post' -Uri $apiHost/api/vm/v8/getuserserverlist/?sync=true -Body $requestBody -Headers $requestHeader
    $uuid = $request.uuid
    do{
        Start-Sleep -Seconds 5
        if ($log){
            $Log_Status = "Performing getResourceData/$uuid GET for data for page ${offset} listing ${size} servers per page"
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
            write-host ($Log_Status) -ForegroundColor Blue
        }
        $resourceData = Invoke-RestMethod -Method 'GET' -Uri $apiHost/api/async/task/$uuid -Headers $asyncHeader
    }
    until ($resourceData.taskState -eq "FINISHED")
    
    $processOutput = $resourceData.processOutput | ConvertTo-Json | ConvertFrom-Json

    if ($processOutput.type -eq "SUCCESS"){
        $message = $processOutput.message | ConvertFrom-Json

        # Return just the total numbers of servers
        if ($FnsCall -eq 1) {
            $total_count = $message.total_count  | ConvertFrom-Json
            return $total_count
        }

        # Return array of server based on page number abd number if servers per page
        elseif ($FnsCall -eq 2) { 
            $PageXServerArray = @()
            for ($i=0; $i -lt $message.data.length; $i++)  { $PageXServerArray += $message.data[$i] }
            return $PageXServerArray
         }

         # Return Unknown condition
        else{}
    }
    # Call did not have success
    else {}
}

function getuserserverlist {
    param($ownerId, $OutputType, $OutputFileName)

    $ForegroundColor = "Green"
    $Log_Status      = "Initial_Value"
    $HdrFtrSpacing   = "-----------------------------------------------------------------------------"

    $serverCount = DoApiFnsCalls -ownerId $ownerId -vraEnv $vraEnv -offset $offset -size 1 -FnsCall 1
    if ($serverCount -gt 0){

        $ForegroundColor = "Green"
        $Log_Status = "Retrieving list of ${serverCount} servers for ${ownerId}.  Retired servers NOT listed"
        if ($OutputType -eq "File") {  
            Add-Content $OutputFileName $HdrFtrSpacing 
            Add-Content $OutputFileName $Log_Status 
            Add-Content $OutputFileName $HdrFtrSpacing 
        }
        write-host ($HdrFtrSpacing) -ForegroundColor $ForegroundColor
        write-host ($Log_Status) -ForegroundColor $ForegroundColor
        write-host ($HdrFtrSpacing) -ForegroundColor $ForegroundColor

        # begin serverl list retrieveal loop
        $pageNumber = 1
        $ServerListUnSortedArray = @()
        For ($i=0; $i -le $serverCount; $i=$i+$size) {
            $SinglePageArray = DoApiFnsCalls -ownerId $ownerId -vraEnv $vraEnv -offset $pageNumber -size $size -FnsCall 2
            foreach ($server in $SinglePageArray) { $ServerListUnSortedArray += $server }
            $pageNumber = $pageNumber + 1
        }

        $ServerListSortedArray = $ServerListUnSortedArray | Sort vmDateCreated -descending   # MAC issue for the sort option
        foreach ($item in $ServerListSortedArray) {
            #--------------------------------------------------
            # All Returned Items that can be displayed
            $Name = $item.Name
            $configItemId = $item.configItemId
            $vmDateCreated = $item.vmDateCreated
            $requestId = $item.requestId
            $ownersRef = $item.ownersRef
            $operatingSystem = $item.operatingSystem
            $ipAddress = $item.ipAddress
            $status = $item.status
            $serverName = $item.serverName
            $serverStage = $item.serverStage
            #--------------------------------------------------

            $Server_Status = "${serverName}, RequestID: ${requestId}, created: ${vmDateCreated}, State: ${serverStage}"
            if ($OutputType -eq "File") {  Add-Content $OutputFileName $Server_Status  }
            
            switch -Exact ($serverStage) {
                "Assigned" { $statusColor = "DarkYellow" }
                "Retired" { $statusColor = "DarkGray" }
                "Services Load" { $statusColor = "DarkCyan" }
                "Steady State" { $statusColor = "DarkGreen" }
                default { $statusColor = "Gray" }
            }

            if ( $serverStage -ne "Retired") {
                write-host ($Server_Status) -ForegroundColor $statusColor
            }
        }

        if ($OutputType -eq "File") {  Add-Content $OutputFileName $HdrFtrSpacing   }
        write-host ($HdrFtrSpacing) -ForegroundColor "Green"
    }
    else {
        $ForegroundColor = "yellow"
        $Log_Status = $processOutput.message +"`r`n Either: ${ownerId} does not own any servers, or ID: ${ownerId} is invalid `r`n"
        if ($OutputType -eq "File") {  Add-Content $OutputFileName $Log_Status  }
        write-host ($Log_Status) -ForegroundColor $ForegroundColor        
    }
}
# End Function block-----------------------------------

# Begin Program Logic-----------------------------------

if ( $kb ) { 

    fnsPreFlightWork
    $ownerId = Read-Host -Prompt 'Enter ownerId'
    getuserserverlist -ownerId $ownerId -OutputType "Screen" -OutputFileName ""
}
elseif ( ($list -and ($screen -or $file)) ) {

    fnsPreFlightWork
    $InputFileName = "UserList.txt"
    $RunDateTime = (Get-Date -Format "yyyy_MM_dd_HHmmtt") 
    $OutputFileName = "LogFiles/getuserserverlist_${RunDateTime}.txt"

    write-host ("`r`n----- Process Starting -----`r`n") -ForegroundColor "Yellow"
    if ($file) {
        if (Test-Path $OutputFileName) { write-host ("`r`n**** ${OutputFileName} exists, erasing current content data for new run****`r`n") -ForegroundColor "Yellow" }
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
            if ($screen) {  getuserserverlist -ownerId $owner -OutputType "Screen" -OutputFileName "" }
            elseif ($file) {  getuserserverlist -ownerId $owner -OutputType "File" -OutputFileName $OutputFileName }
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
    echo "  ./util_getuserserverlist.ps1 -list -file           Pull servers from UserList.txt, results sent getuserserverlist_....txt"
    echo "  ./util_getuserserverlist.ps1 -list -file  -log     Logging and Pull servers from UserList.txt, results sent getuserserverlist_....txt"
    echo "--------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------