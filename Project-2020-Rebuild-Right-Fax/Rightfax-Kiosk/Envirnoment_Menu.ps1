function BAI{
    Invoke-expression "& .\Configure-BAI-Menu.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function FAX{
    Invoke-expression "& .\Configure-FAX-Menu.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function BAIAH{
    Invoke-expression "& .\Configure-AH-BAI-Menu.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function FAXAH{
    Invoke-expression "& .\Configure-AH-FAX-Menu.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SB{
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}
function Start_Menu{
    Write-Host '
    *************************************************
    *           Select Which Environment do         *
    *               you want to configure           *
    *************************************************
    *   Type 1 Enterprise Fax BAI                   *
    *                                               *
    *   Type 2 Enterprise Fax                       *                  
    *                                               *
    *   Type 3 AdHoc Enterprise Fax BAI             *
    *                                               *
    *   Type 4 AdHoc Enterprise Fax                 *
    *                                               *
    *   Type 5 Sandbox Configuration                *      
    *                                               *
    *   Type Main To Return To The Master Menu      *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){BAI($addorchange)}
    if ($addorchange -like "2"){FAX($addorchange)}
    if ($addorchange -like "3"){BAIAH($addorchange)}
    if ($addorchange -like "4"){FAXAH($addorchange)}
    if ($addorchange -like "5"){SB($addorchange)}
    if ($addorchange -like "Main"){Master_Menu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)