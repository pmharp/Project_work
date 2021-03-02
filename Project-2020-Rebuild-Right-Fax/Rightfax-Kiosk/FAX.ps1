function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAXAStage{
    Invoke-expression "& .\FAX-Stage-A.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}
function FAXBStage{
    Invoke-expression "& .\FAX-Stage-B.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function FAXAProd{
    Invoke-expression "& .\FAX-Prod-A.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function FAXBProd{
    Invoke-expression "& .\FAX-Prod-B.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *        Right Fax FAX Build Menu               *
    *************************************************
    *     Collective A                              *
    *       Type 1 for Non-Prod                     *
    *       Type 2 for Prod                         *
    *                                               *
    *     Collective B                              *                  
    *       Type 3 for Non-Prod                     *
    *       Type 4 for Prod                         *
    *                                               *
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){FAXAStage($addorchange)}
    if ($addorchange -like "2"){FAXAProd($addorchange)}
    if ($addorchange -like "3"){FAXBStage($addorchange)}
    if ($addorchange -like "4"){FAXBProd($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}

} 

Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }

Start_Menu($select)