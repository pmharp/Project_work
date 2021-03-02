function BackMenu{
    Clear-host
    Invoke-expression "& .\FAX_BAI.PS1 -Credential $Cred"
}
'
*************************************************
*                                               *
* You are entering is the Non-Prod Seed server  *
* build section.  If you want to proceed Press  *
* Enter to Continue or N to go back to previous *
* menu.                                         *
*************************************************
'
$addorchange = Read-Host -Prompt 'Enter Choice'
if ($addorchange -like "Y"){MasterMenu($addorchange)
else 
 Backmenu($select)   
}

Write-Host "Need to verify that the Information is are correct."
Write-Host "Go down to Windows App Layer Section and check App Count"
Write-Host "for the number of servers that need to be built."
Write-Host "Update if necessary."

Pause

Start-Process -FilePath "C:\Program Files\Microsoft VS Code\Code.exe" terraform.tfvars

Write-Host "In the Windows_ODI_App file you will need to check"
Write-Host "to see if you have the correct drive settings"

Pause

Start-Process -FilePath "C:\Program Files\Microsoft VS Code\Code.exe" windows_odi_app.tf

Write-Host "Starting the Build Server Process"

Pause

Invoke-expression "& .\_RunTF.PS1 -Credential $Cred"

Write-Host "Servers have been built, starting the "
Write-host "new server name collection"

Pause

$Serverdata = Get-Content terraform.tfstate
foreach($Server in $Serverdata){ 
    if ($server -like "*wn0000*") {
        $String = $Server
        $count = $String.Length
        If ($count -eq 24) {
            $string1 = $string.Trim()
            $string2 = $string1.trim([Char]" ")
            $String3 = $string2 -replace ".{4}$" 
            $string4 = $String3.tostring().substring(1,11)
            $string4 | out-file -FilePath "servers.txt" -Append
            $string4 | out-file -FilePath "serverseedsn.txt" -Append
            $string4 | out-file -FilePath "serverHist.txt" -Append
        }
    }
}
Copy-Item "Servers.txt" -Destination "C:\Temp\"
./inspec_remote_master_v2.ps1
./Set-ADAccountAdmin.ps1 -InputFile servers.txt -Trustee EFXDev_Ark
./Set-ADAccountAdmin.ps1 -InputFile servers.txt -Trustee Rightfax_Ark
./Set-ADAccountAdmin.ps1 -InputFile servers.txt -Trustee OpsMgrAdmins_ARK
./Set-ADAccountAdmin.ps1 -InputFile servers.txt -Trustee IISADMINS
./Set-ADAccountUsers.ps1 -Inputfile servers.txt -Trustee Rightfax
Remove-Item terraform.tfstate

*************************************************
*                                               *
* The build of the Seed servers has been        *
* completed and the server names are located in *
* the ServersSeed.txt file.  Servers are to be  *
* configured.                                   *
*************************************************
Pause

Backmenu($select)