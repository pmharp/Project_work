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

function RDTIN1{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\BAI-IN1\RDT\BAISRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPIN1{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\BAI-IN1\APP\BAIAPPIN.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function TaskIN1{
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\BAI-IN1\Task\BAITASKIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebIN1{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\BAI-IN1\Web\BAIWebIN.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}
function SQLIN1{
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Stage\BAI-IN1\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax BAI Build Menu For Stage IN1      *
    *************************************************
    *          Collective IN1                       *
    *               STAGE                           *
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
    if ($addorchange -like "1"){APPIN1($addorchange)}
    if ($addorchange -like "2"){RDTIN1($addorchange)}
    if ($addorchange -like "3"){TaskIN1($addorchange)}
    if ($addorchange -like "4"){WebIN1($addorchange)}
    if ($addorchange -like "5"){SQLIN1($addorchange)}
    if ($addorchange -like "R"){FAXBAI($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)