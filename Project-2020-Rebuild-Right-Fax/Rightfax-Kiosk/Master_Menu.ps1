function Envir{
    clear-host
    Invoke-expression -Command "& .\Envirnoment_menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function ServerBuilds{
    clear-host
    Invoke-expression "& .\serverbuilds.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Utility{
    clear-host
    Invoke-expression "& .\util-menu.ps1 -Credential $Cred"
    Start_Menu($select)
}

function adhoc{
    clear-host
    Invoke-expression "& .\AdHoc.ps1 -Credential $Cred"
    Start_Menu($select)
}


function Start_Menu{
    Write-Host '
    *************************************************
    *           Right Fax Kiosk                     *
    *************************************************
    *   Type 1 Server Builds                        *
    *                                               *
    *   Type 2 Server Configurations                *                  
    *                                               *
    *   Type 3 Utilities                            *
    *                                               *
    *   Type 4 Adhoc Server Builds                  *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){ServerBuilds($addorchange)}
    if ($addorchange -like "2"){Envir($addorchange)}
    if ($addorchange -like "3"){Utility($addorchange)}
    if ($addorchange -like "4"){Adhoc($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)
    