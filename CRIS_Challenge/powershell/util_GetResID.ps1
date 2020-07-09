
# powershell command to call web site and get data back for servers defined in a flat file

# Designed to 
# .  ./util_GetResID.ps1 -getResID  keyboard input results sent to screen

# *******  New functions to add. ********
#  Replace the main.tf uid and pwd with the hardcoded values input from user
#     Need New Function built for this
#  Run the "terraform import Resource.ServerLabel ResourceID" command in the day1_initialbuilds folder
#  Run "./Day1_Orchestration.ps1 -runtf" from the powershell folder (may need 2X)
#  reset the main.tf uid and pwd back to original setting
#     Need New Function built for this



param (
    [switch]$getResID = $false
)

# Begin Variable block - Initializing--------------
$vrahost = "https://vra.ms.ds.uhc.com"
$content = "application/json"
$accept = "application/json"
# End Variable block-----------------------------------

# Begin Function Logic-----------------------------------
function getResourceID {
    param($svrShortName)

    $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
    [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
    $w_usr_id = Read-Host -Prompt 'Primary Windows ID'
    $w_usr_pwd = Read-Host -Prompt 'Windows ID Password' -AsSecureString
    $w_usr_pwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($w_usr_pwd))

    echo "`r`n"
    $authenticationbody = @{"username"="$w_usr_id"; "password"="$w_usr_pwd"; "tenant"="optumprd01"} | ConvertTo-Json
    try {
        $authentication = Invoke-RestMethod -Method 'Post' -Uri $vrahost/identity/api/tokens -Body $authenticationbody -ContentType $content
    } catch {
        Write-Host "Authentication Failed"
        Write-Error $_.Exception.Message.ToString()
        exit
    }
    $token = $authentication.id
    $svrResourceId = Invoke-RestMethod -Method 'Get' -Uri $vrahost/catalog-service/api/consumer/resources?%24filter=name+eq+"'"$svrShortName"'" -Headers @{"accept"=$accept; "Authorization"="Bearer $token"}
    if($svrResourceId.content.Count -eq 0){
        Write-Host "${svrShortName}: in undetermined state (no access, decommed, powered off)" -ForegroundColor "Red"
    } else {
        $resourceid = $svrResourceId.content.requestId
        if ($resourceid -eq $null) { 
            $GetResourceID_Status = "${svrShortName} --> Found, but NULL Resource ID (usually ESC migration to vRa)" 
            Write-Host $GetResourceID_Status -ForegroundColor "yellow"
        }
        else{
            $GetResourceID_Status = "${svrShortName}  -->  ${resourceid}" 
            Write-Host $GetResourceID_Status -ForegroundColor "Green"
        }
    }
    echo "`r`n"
}
# End Function block-----------------------------------

# Begin Program Logic-----------------------------------
if ( $getResID ) { 
    # Get values from user and builds commands
    echo "`r`n" 
    $svrShortName = Read-Host -Prompt 'Enter Server ShortName'
    getResourceID  -svrShortName $svrShortName
}
else {
    echo "`r`n--------------------------------------------------------------------------------------" 
    echo "                         NO PARAMETER SPECIFIED" 
    echo "./util_GetResID.ps1 -getResID     keyboard input results sent to screen"
    echo "--------------------------------------------------------------------------------------`r`n" 
}
# End Program Logic-----------------------------------