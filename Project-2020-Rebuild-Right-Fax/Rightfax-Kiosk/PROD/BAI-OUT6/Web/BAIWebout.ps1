function BackMenu{
    Clear-host
    Invoke-expression "& .\FAX_BAI.PS1 -Credential $Cred"
}
'
*************************************************
*                                               *
* You are entering in the Prod Web OUT6 server  *
* build section.  If you want to proceed Press  *
* Enter to Continue or N to go back to previous *
* menu.                                         *
*************************************************
'
$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "N"){Backmenu($addorchange)  
}

Write-Host "Starting the Build Server Process"

Invoke-expression "& .\_RunTF.PS1 -Credential $Cred"

Write-Host "Servers have been built, starting the "
Write-host "new server name collection"

Pause

$Serverdata = Get-Content terraform.tfstate
foreach($Server in $Serverdata){ 
    if ($server -like "*wp0000*") {
        $String = $Server
        $count = $String.Length
        If ($count -eq 24) {
            $string1 = $string.Trim()
            $string2 = $string1.trim([Char]" ")
            $String3 = $string2 -replace ".{4}$" 
            $string4 = $String3.tostring().substring(1,11)
            $string4 | out-file -FilePath "E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt" -Append
            $string4 | out-file -FilePath "E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\serverHist.txt" -Append
        }
    }
}
Copy-Item "E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt" -Destination "C:\Temp\"
./inspec_remote_master_v2.ps1
./Set-ADAccountAdmin.ps1 -InputFile E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt -Trustee EFXBAI_OUT_ARK
./Set-ADAccountAdmin.ps1 -InputFile E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt -Trustee Rightfax_Ark
./Set-ADAccountAdmin.ps1 -InputFile E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt -Trustee OpsMgrAdmins_ARK
./Set-ADAccountAdmin.ps1 -InputFile E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt -Trustee IISADMINS
./Set-ADAccountUsers.ps1 -Inputfile E:\SC\Rightfax-Kiosk\server-text-files\Prod\BAI\OUT6\Task\servers.txt -Trustee Rightfax
Remove-Item terraform.tfstate

Write-Host '
*************************************************
*                                               *
* The build of the Seed servers has been        *
* completed and the server names are located in *
* the E:\SC\Rightfax-Kiosk\server-text-files\   *
* Prod Directory.  Servers are to be            *
* configured.                                   *
*************************************************
'
Pause

Backmenu($select)