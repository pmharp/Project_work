function AStage{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\Stage\FAX\A\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\Stage\FAX\A\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\Stage\FAX\A\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\Stage\FAX\A\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\Stage\FAX\A\TASK\servers.txt
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