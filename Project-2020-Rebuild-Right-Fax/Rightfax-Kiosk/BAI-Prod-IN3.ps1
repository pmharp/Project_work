function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXBAI{
    Invoke-expression "& .\FAX_BAI.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function RDTIN3{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-IN3\RDT\BAIRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPIN3{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-IN3\APP\BAIAPPIN.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function TaskIN3{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-IN3\Task\BAITASKIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebIN3{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-IN3\Web\BAIWebIN.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}
function SQLIN3{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-IN3\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax BAI Build Menu For Prod IN3       *
    *************************************************
    *          Collective IN3                       *
    *               PROD                            *
    *     Type 1 for App Servers (Count 4)          *       
    *     Type 2 for RDT Servers (Count 8)          *         
    *     Type 3 for Task Servers (Count 1)         *         
    *     Type 4 for Web Servers (Count 1)          *
    *     Type 5 for SQL-AO Cluster (Count 1)       *                                               
    *                                               *                                               
    *   Type R to return to Right Fax BAI Build Menu*
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){APPIN3($addorchange)}
    if ($addorchange -like "2"){RDTIN3($addorchange)}
    if ($addorchange -like "3"){TaskIN3($addorchange)}
    if ($addorchange -like "4"){WebIN3($addorchange)}
    if ($addorchange -like "5"){SQLIN3($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)