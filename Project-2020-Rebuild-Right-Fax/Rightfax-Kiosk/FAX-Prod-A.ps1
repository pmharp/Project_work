function MasterMenu{
    Set-Location -Path "E:\SC\Rightfax-Kiosk"
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXBAI{
    Set-Location -Path "E:\SC\Rightfax-Kiosk"
    clear-host
    Invoke-expression "& .\FAX.PS1 -Credential $Cred"
    Start_Menu($select)
}

function RDTA{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Prod\Fax-A\RDT\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\FAX-A\RDT\BAIRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPA{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Prod\Fax-A\APP\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\FAX-A\APP\BAIAPPIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function TaskA{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Prod\Fax-A\Task\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\FAX-A\Task\BAITaskIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebA{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Prod\Fax-A\Web\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\FAX-A\Web\BAIWebIN.PS1 -Credential $Cred"
    Start_Menu($select)
}
function SQLA{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Prod\Fax-A\SQL-AO\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\FAX-A\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax Build Menu For Prod Collective    *
    *************************************************
    *                Collective A                   *
    *                   Prod                        *
    *     Type 1 for App Servers (Count 4)          *       
    *     Type 2 for RDT Servers (Count 8)          *         
    *     Type 3 for Task Servers (Count 1)         *         
    *     Type 4 for Web Servers (Count 1)          *
    *     Type 5 for SQL-AO Cluster (Count 1)       *                                               
    *                                               *                                               
    *   Type R to return to Right Fax Build Menu    *
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){APPA($addorchange)}
    if ($addorchange -like "2"){RDTA($addorchange)}
    if ($addorchange -like "3"){TaskA($addorchange)}
    if ($addorchange -like "4"){WebA($addorchange)}
    if ($addorchange -like "5"){SQLA($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)
