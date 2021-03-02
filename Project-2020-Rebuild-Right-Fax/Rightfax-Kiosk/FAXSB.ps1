function MasterMenu{
    Set-Location -Path "E:\SC\Rightfax-Kiosk"
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function RDT{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\RDT\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-A\RDT\BAISRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APP{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\APP\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\APP\BAIAPPIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Task{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\Task\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\Task\BAISTaskIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Web{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\Web\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\Web\BAIWebIN.PS1 -Credential $Cred"
    Start_Menu($select)
}
function SQL{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\SQL-AO\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\SANDBOX\FAX-B\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax Build Menu For Sand Box           *
    *************************************************
    *                Collective SB                  *
    *                                               *
    *     Type 1 for App Servers (Count 4)          *       
    *     Type 2 for RDT Servers (Count 12)         *         
    *     Type 3 for Task Servers (Count 1)         *         
    *     Type 4 for Web Servers (Count 1)          *
    *     Type 5 for SQL-AO Cluster (Count 1)       *                                               
    *                                               *                                               
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){APP($addorchange)}
    if ($addorchange -like "2"){RDT($addorchange)}
    if ($addorchange -like "3"){Task($addorchange)}
    if ($addorchange -like "4"){Web($addorchange)}
    if ($addorchange -like "5"){SQL($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)
