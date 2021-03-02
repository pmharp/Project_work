function MasterMenu{
    Set-Location -Path "E:\SC\Rightfax-Kiosk"
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function RDT{
    clear-host
    Set-Location -Path "E:\SC\Rightfax-Kiosk\DEV\RDT\"
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\DEV\RDT\BAIRDTIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function APP{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\DEV\APP\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\DEV\APP\BAIAPPIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Task{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\DEV\Task\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\DEV\Task\BAITASKIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Web{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\DEV\Web\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\DEV\Web\BAIWebIN.PS1 -Credential $Cred"
    Start_Menu($select)
}
function SQL{
    Set-Location -Path "E:\SC\Rightfax-Kiosk\DEV\SQL-AO\"
    clear-host
    Invoke-expression -Command "E:\SC\Rightfax-Kiosk\DEV\SQL-AO\BAISQLIN.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *        Right Fax Build Menu For DEV           *
    *************************************************
    *                Collective DEV                 *
    *                                               *
    *     Type 1 for App Servers (Count 12)         *       
    *     Type 2 for RDT Servers (Count 18)         *         
    *     Type 3 for Task Servers (Count 1)         *         
    *     Type 4 for Web Servers (Count 12)         *
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
