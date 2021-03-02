function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXBAI{
    clear-host
    Invoke-expression "& .\FAX_BAI.PS1 -Credential $Cred"
    Start_Menu($select)
}


function FAX{
    clear-host
    Invoke-expression "& .\FAX.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXDEV{
    clear-host
    Invoke-expression "& .\FAX-DEV.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Sandbox{
    clear-host
    Invoke-expression "& .\faxsandbox.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *        Right Fax  Select Build Group Menu     *
    *************************************************
    *   Enterprise Fax BAI (UHGWM110-016291)        *
    *     Type 1 for FAX BAI                        *         
    *                                               *
    *   Enterprise Fax (UHGWM110-013393)            *                  
    *     Type 2 for Enterprise Fax                 *
    *     Type 3 for Fax DEV                        *                                 
    *     Type 4 for Fax Sandbox                    *
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){FAXBAI($addorchange)}
    if ($addorchange -like "2"){FAX($addorchange)}
    if ($addorchange -like "3"){FAXDEV($addorchange)}
    if ($addorchange -like "4"){Sandbox($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Start_Menu($select)
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }