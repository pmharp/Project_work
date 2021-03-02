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

function RDTB{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Stage\Fax-B\RDT\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\Fax-B\RDT\BAISRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPB{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Stage\Fax-B\APP\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\Fax-B\APP\BAIAPPIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function TaskB{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Stage\Fax-B\Task\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\Fax-B\Task\BAITASKIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebB{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Stage\Fax-B\Web\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\Fax-B\Web\BAIWebIN.PS1 -Credential $Cred"
    Start_Menu($select)
}
function SQLB{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\Stage\Fax-B\SQL=AO\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\Fax-B\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax Build Menu For Stage Collective   *
    *************************************************
    *                Collective B                   *
    *                   STAGE                       *
    *     Type 1 for App Servers (Count 6)          *       
    *     Type 2 for RDT Servers (Count 18)         *         
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
    if ($addorchange -like "1"){APPB($addorchange)}
    if ($addorchange -like "2"){RDTB($addorchange)}
    if ($addorchange -like "3"){TaskB($addorchange)}
    if ($addorchange -like "4"){WebB($addorchange)}
    if ($addorchange -like "5"){SQLB($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)
