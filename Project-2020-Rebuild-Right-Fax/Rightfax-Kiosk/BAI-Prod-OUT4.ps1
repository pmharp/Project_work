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

function RDTOUT4{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT4\RDT\BAISRDTOUT.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPOUT4{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT4\APP\BAIAPPOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function TaskOUT4{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT4\Task\BAITASKOUT.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebOUT4{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT4\Web\BAIWebOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}
function SQLOUT4{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT4\SQL-AO\BAISQLOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax BAI Build Menu For Prod OUT4      *
    *************************************************
    *          Collective OUT4                      *
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
    if ($addorchange -like "1"){APPOUT4($addorchange)}
    if ($addorchange -like "2"){RDTOUT4($addorchange)}
    if ($addorchange -like "3"){TaskOUT4($addorchange)}
    if ($addorchange -like "4"){WebOUT4($addorchange)}
    if ($addorchange -like "5"){SQLOUT4($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)