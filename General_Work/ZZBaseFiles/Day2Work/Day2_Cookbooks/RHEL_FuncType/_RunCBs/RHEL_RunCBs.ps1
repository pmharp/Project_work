
# powershell command to call web site and get data back for servers defined in a flat file

# Designed to 
# .  ./RHEL_RunCBs.ps1 -kb   keyboard input results sent to screen
# .  ./RHEL_RunCBs.ps1 -file Pull servers from CB_SvrList.txt, detail results sent SvrDetail.txt

param (
    [switch]$kb = $false,
    [switch]$file = $false
)

# Begin Variable block - Initializing--------------
$Serverdomains = @(
    (".ms.ds.uhc.com"),         # Core Windows domain
    (".uhc.com"),               # Core Linux domain
    (".dmzmgmt.uhc.com")        # DMZ dommain for windows and Linux
)
# End Variable block-----------------------------------

# Begin Function Logic-----------------------------------
function ParseTextFile {

    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $InputTextFile
    )

    if (Test-Path $InputTextFile)  { 
        # Get file content, remove blank lines and edit data for shortnames
        # create array to loop through and remove any empty lines
        #  May need to add conditional tests based on contents of file
        $InputTextFileContents = Get-Content($InputTextFile)
        $InputTextFileContents = $InputTextFileContents | ? {$_}
        $InputTextFileContents = $InputTextFileContents.replace(".ms.ds.uhc.com","").replace(".uhc.com","").replace(".dmzmgmt.uhc.com","")
        $InputTextFileContents = $InputTextFileContents.replace(" ","")

        # Split on "," and place into array elements and return array
        $TextFileContentsArray = $InputTextFileContents.split(",",[System.StringSplitOptions]::RemoveEmptyEntries)
        return $TextFileContentsArray
    }
    else {
        write-host ("`r`n**** ${InputTextFile} does NOT EXIST in current directory ****`r`n") -ForegroundColor "Red"
        exit
    }    
}

function check_server_type {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $fnsSvrName
    )
    # for testing wincore=apved59387, DMZWinSvr=apved59507, DMZRHELSvr=apvrd59456, db=
    #   DEW stuff corerhel: apvrd59386

    # Determine server type     
    # DB test (look at 1st char)
    if ($fnsSvrName.Substring(0,1) -eq "d") { return $false}
    # Windows test  (look at 4st char)
    if ($fnsSvrName.Substring(3,1) -eq "e") { return $false}
    # # RHEL test  (look at 4st char)
    # if ($fnsSvrName.Substring(3,1) -eq "r") { return $false}

    # Detemine if server is in the DMZ, currently unable to process that
    foreach($dnsdomain in $Serverdomains)  {
        $TryingFQDN = ${fnsSvrName} + ${dnsdomain}
        $validDomain = Resolve-DnsName -Name $TryingFQDN  -EA SilentlyContinue
        If ($validDomain.Name -match $TryingFQDN) {
             if ($dnsdomain -match ".dmzmgmt.uhc.com") { return $false }
             else { return $true }
        }
    }
    # could not find a valid entry in DNS all domain tests failed
    return $false
}

function ProcessRunlistOnServer {
    Param
    (
         [Parameter(Mandatory=$true, Position=0)]
         [string] $fnsSvrName,
         [Parameter(Mandatory=$true, Position=1)]
         [string[]] $fnsCBArray,
         [Parameter(Mandatory=$true, Position=0)]
         [string] $UserID
    )
    
    # Copy entire cookbooks folder to server regardless of runlinst contents
    Invoke-Expression "clear"
    # $Cmd_PSCP = "pscp  -l ${UserID} -pw ${UserPWD} -r cookbooks ${fnsSvrName}.uhc.com:/home/${UserID}"
    $Cmd_PSCP = "pscp  -l ${UserID} -r cookbooks ${fnsSvrName}.uhc.com:/home/${UserID}"
    set-location "../"
    write-host "`r`nWaiting for PWD to ${fnsSvrName}.uhc.com to begin copying: ....." -foregroundcolor "Yellow" 
    # Add 2>&1 to end to send stdout to null
    Invoke-Expression $Cmd_PSCP
    if ( $LastExitCode -eq 0) { 
        write-host "status - DONE" -foregroundcolor "Green" 
        foreach ($cookbook in $fnsCBArray) {
            $Cmd_SSH = "ssh -oStrictHostKeyChecking=no ${UserID}@${fnsSvrName}.uhc.com sudo chef-client -zo ${cookbook}"
            write-host "`r`nWaiting for PWD to ${fnsSvrName}.uhc.com to begin processing CB: ${cookbook}....`r`n" -foregroundcolor "Yellow" 
            Invoke-Expression $Cmd_SSH
        }
        write-host "Cookbook Runs on ${fnsSvrName}.uhc.com completed, run INSPEC tests for final verification" -foregroundcolor "Green" 
    }
    else { write-host "status - COPY ERROR - Exiting" -foregroundcolor "RED" }
    set-location "_RunCBs"
}

function Sanitychecks {
    # Write code to remove all github hooks .git
    # Get-childItem -Recurse -Filter placeholder.txt | Remove-Item  -Force
}
# End Function block-----------------------------------

# Begin Program Logic-----------------------------------
if ( $kb ) { 
    #   Get the server name and the display all the entrys in the cbrunlist 
    #   Get approval to continue, then prompt for ID and PWD, then run
    Invoke-Expression 'clear'
    $svrShortName = Read-Host -Prompt 'Enter RHEL Server ShortName'
    $isServerGood = check_server_type -fnsSvrName $svrShortName
    if ($isServerGood){
        write-host  "`r`n---------------------------------------------------------------`r`n"
        write-host -nonewline "Running following Cookbooks in order on server: "
        write-host "${svrShortName}`r`n"  -foregroundcolor "Green"
        $CookBookArray = ParseTextFile -InputTextFile "CB_RunList.txt"
        foreach ($cookbook in $CookBookArray) { write-host "  ${cookbook}"  -foregroundcolor "Green" }
        write-host "`r`n---------------------------------------------------------------`r`n"
        write-host -nonewline "Confirm would you like to Continue? (Y/N) "  -foregroundcolor "Yellow"
        $response = read-host
        if ( $response -ne "Y" ) { exit } 
        
        # Get ID and pwd to do the work on server
        $l_usr_id = Read-Host -Prompt 'Enter Secondary UNIX ID'
        ProcessRunlistOnServer -fnsSvrName $svrShortName -fnsCBArray $CookBookArray  -UserID $l_usr_id 
    }
    else {
        write-host "`r`n---------------------ERROR ERROR------------------------`r`n" -foregroundcolor "Red"
        write-host "  Cannot run cookbooks on ${svrShortName}`r`n" -foregroundcolor "Yellow"
        write-host "  Possible reasons why:"
        write-host "    Server name given is invalid"
        write-host "    Server is a Windows server, not RHEL"
        write-host "    Server is a DB server, access restricted"
        write-host "    Server is Windows AND member of dmzmgmt.uhc.com`r`n"
        write-host "`---------------------ERROR ERROR------------------------`r`n" -foregroundcolor "Red"
    }
}
elseif ( $file ) {

    $CookBookArray = ParseTextFile -InputTextFile "CB_RunList.txt"
    $SvrListArray = ParseTextFile -InputTextFile "CB_SvrList.txt"

    # Get output file ready to use -----------------------------------------
    $RunDateTime = (Get-Date -Format "yyyy_MM_dd_HHmmtt") 
    $OutputFileName = "reports/CB_Run_Details_${RunDateTime}.txt"
    
    if (Test-Path $OutputFileName) { write-host ("`r`n**** ${OutputFileName} exists, erasing current content data for new run****`r`n") -ForegroundColor "Yellow" }
    write-host ("`r`n----- Process Starting -----`r`n") -ForegroundColor "Yellow"
    Out-File -FilePath $OutputFileName
    $headerText = "Beginning Cookbook Run on " +  $RunDateTime
    Add-Content $OutputFileName $headerText
    # END  Output file work -------------------------------------------------

    # Begin Validation -----------------------------------------------------------------
    write-host  "`r`n---------------------------------------------------------------`r`n"
    write-host  "Running following Cookbooks in order per server"
    foreach ($cookbook in $CookBookArray) { write-host "  ${cookbook}"  -foregroundcolor "Green" }
    write-host  "`r`n------ SERVER LIST ------"
    foreach ($svr in $SvrListArray)  { 
        $svr = $svr.ToLower()
        $isServerGood = check_server_type -fnsSvrName $svr
        if ($isServerGood) { write-host "${svr}"  -foregroundcolor "Green" }
        else { write-host "  ${svr} - invalid"  -foregroundcolor "yellow" }
    }
    write-host "`r`n---------------------------------------------------------------`r`n"
    write-host -nonewline "Confirm would you like to Continue? (Y/N) "  -foregroundcolor "Yellow"
    $response = read-host
    if ( $response -ne "Y" ) { exit } 
    # END Validation -----------------------------------------------------------------

    # BEGIN PROCESSING -----------------------------------------------------------------
    # Get ID to do the work on server
    $l_usr_id = Read-Host -Prompt 'Enter Secondary UNIX ID'

    foreach ($svr in $SvrListArray)  { 
        $svr = $svr.ToLower()
        $isServerGood = check_server_type -fnsSvrName $svr
        if ($isServerGood) { 
            write-host "Processiing ${svr}"  -foregroundcolor "Green" 
            ProcessRunlistOnServer -fnsSvrName $svr -fnsCBArray $CookBookArray -UserID $l_usr_id 
        }
        else { write-host "  SKipping ${svr} - invalid"  -foregroundcolor "yellow" }
    }
    # END PROCESSING -----------------------------------------------------------------
}
else {
    echo "`r`n--------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "./RHEL_RunCBs.ps1 -kb      keyboard input for Single Server and results sent to screen"
    echo "./RHEL_RunCBs.ps1 -file    Pull servers from CB_SvrList.txt, results sent SvrDetail.txt"
    echo "--------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------