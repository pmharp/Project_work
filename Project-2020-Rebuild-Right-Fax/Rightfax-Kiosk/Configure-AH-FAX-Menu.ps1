function AProd{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-A\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-A\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-A\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-A\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-A\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}  

function BProd{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-B\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-B\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-B\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-B\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\FAX-B\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}  

function AStage{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-A\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-A\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-A\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-A\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-A\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}  

function BStage{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-B\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-B\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-B\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-B\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\FAX-B\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}

function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *         Right Fax FAX Select                  *
    *           Configuration Menu                  *
    *             For AdHoc Builds                  *
    *************************************************
    *     Collective A                              *
    *       Type 1 for Non-Prod                     *
    *       Type 2 for Prod                         *
    *                                               *
    *     Collective B                              *                  
    *       Type 3 for Non-Prod                     *
    *       Type 4 for Prod                         *
    *                                               *
    *                                               *
    *   Type Main to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){AStage($addorchange)}
    if ($addorchange -like "2"){AProd($addorchange)}
    if ($addorchange -like "3"){BStage($addorchange)}
    if ($addorchange -like "4"){BProd($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}

}

Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)