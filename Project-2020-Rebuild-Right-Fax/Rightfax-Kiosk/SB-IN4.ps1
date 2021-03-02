function MasterMenu{
    Set-Location -Path "E:\SC\Rightfax-Kiosk"
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXBAI{
    Set-Location -Path "E:\SC\Rightfax-Kiosk"
    clear-host
    Invoke-expression "& .\faxsandbox.ps1 -Credential $Cred"
    Start_Menu($select)
}

function RDTIN1{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\BAI-IN4\RDT\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Sandbox\BAI-IN4\RDT\BAIRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APPIN1{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\BAI-IN4\APP\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Sandbox\BAI-IN4\APP\BAIAPPIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function TaskIN1{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\BAI-IN4\Task\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Sandbox\BAI-IN4\Task\BAITASKIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function WebIN1{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\BAI-IN4\Web\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Sandbox\BAI-IN4\Web\BAIWebIN.PS1 -Credential $Cred"
    Start_Menu($select)
}
function SQLIN1{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\SANDBOX\BAI-IN4\SQL-AO\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\Sandbox\BAI-IN4\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *   Right Fax Build Menu For Sandbox            *
    *************************************************
    *          Collective IN4                       *
    *                                               *
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