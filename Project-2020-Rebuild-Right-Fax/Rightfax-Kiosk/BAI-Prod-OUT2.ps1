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

function RDTOUT2{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT2\RDT\BAISRDTOUT.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPOUT2{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT2\APP\BAIAPPOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function TaskOUT2{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT2\Task\BAITASKOUT.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebOUT2{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT2\Web\BAIWebOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}
function SQLOUT2{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT2\SQL-AO\BAISQLOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax BAI Build Menu For Prod OUT2      *
    *************************************************
    *          Collective OUT2                      *
    *               Prod                            *
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
    if ($addorchange -like "1"){APPOUT2($addorchange)}
    if ($addorchange -like "2"){RDTOUT2($addorchange)}
    if ($addorchange -like "3"){TaskOUT2($addorchange)}
    if ($addorchange -like "4"){WebOUT2($addorchange)}
    if ($addorchange -like "5"){SQLOUT2($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)