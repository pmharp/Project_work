function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAI{
    Invoke-expression "& .\SBBAIReset.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAX{
    Invoke-expression "& .\SBFAXReset.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *  Sandbox Right Fax Server Build Text file     *        
    *        Reset For Enterprise Fax Menu          *
    *************************************************
    *     Type 1 for BAI                            *       
    *     Type 2 for FAX                            *         
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){BAI($addorchange)}
    if ($addorchange -like "2"){FAX($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }

    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }
        
        Start_Menu($select)
        