function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXDEV{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\DEV\FAX-DEV\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\DEV\FAX-DEV\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\DEV\FAX-DEV\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\DEV\FAX-DEV\Web\servers.txt" -Force
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *     Right Fax Server Build Text file Reset    *        
    *           For DEV Fax Menu                    *
    *************************************************
    *     Type 1 for DEV Fax                        *       
    *                                               *                                               
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){FAXDEV($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }

    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }
        
        Start_Menu($select)
   