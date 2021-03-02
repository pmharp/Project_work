function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXA{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-A\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-A\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-A\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-A\Web\servers.txt" -Force
    Start_Menu($select)
}

function FAXB{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-B\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-B\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-B\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Sandbox\FAX-B\Web\servers.txt" -Force
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *  Sandbox Right Fax Server Build Text file     *        
    *       Reset For Enterprise Fax Menu           *
    *************************************************
    *     Type 1 for Fax A                          *       
    *     Type 2 for Fax B                          *         
    *                                               *                                               
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){FAXA($addorchange)}
    if ($addorchange -like "2"){FAXB($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }

    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }
        
    Start_Menu($select)
       