function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXStageA{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\Web\servers.txt" -Force
    Start_Menu($select)
}

function FAXStageB{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\Web\servers.txt" -Force
    Start_Menu($select)
}

function FAXProdA{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\Web\servers.txt" -Force
    Start_Menu($select)
}

function FAXProdB{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\Web\servers.txt" -Force
    Start_Menu($select)
}

function FAXALL{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-B\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-A\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Stage\FAX-B\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\Prod\FAX-A\Web\servers.txt" -Force
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *     Right Fax Server Build Text file Reset    *        
    *           For Enterprise Fax Menu             *
    *************************************************
    *     Type 1 for Stage Fax A                    *       
    *     Type 2 for Stage Fax B                    *         
    *     Type 3 for Prod Fax A                     *         
    *     Type 4 for Prod Fax B                     *
    *     Type 5 to Reset All Fax                   *                                                
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){FAXStageA($addorchange)}
    if ($addorchange -like "2"){FAXStageB($addorchange)}
    if ($addorchange -like "3"){FAXProdA($addorchange)}
    if ($addorchange -like "4"){FAXProdB($addorchange)}
    if ($addorchange -like "5"){FAXALL($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }

    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }
        
        Start_Menu($select)
        