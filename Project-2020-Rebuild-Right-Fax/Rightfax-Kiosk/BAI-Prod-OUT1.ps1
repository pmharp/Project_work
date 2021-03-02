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

function RDTOUT1{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT1\RDT\BAISRDTOUT.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPOUT1{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT1\APP\BAIAPPOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function TaskOUT1{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT1\Task\BAITASKOUT.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebOUT1{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT1\Web\BAIWebOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}
function SQLOUT1{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Prod\BAI-OUT1\SQL-AO\BAISQLOUT.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax BAI Build Menu For Prod OUT1      *
    *************************************************
    *          Collective OUT1                      *
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
    if ($addorchange -like "1"){APPOUT1($addorchange)}
    if ($addorchange -like "2"){RDTOUT1($addorchange)}
    if ($addorchange -like "3"){TaskOUT1($addorchange)}
    if ($addorchange -like "4"){WebOUT1($addorchange)}
    if ($addorchange -like "5"){SQLOUT1($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)