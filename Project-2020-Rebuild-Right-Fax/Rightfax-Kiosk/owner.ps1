function ownership{
    clear-host
    Invoke-expression "& .\odi_setowner.PS1 -List -Fike -Log -Credential $Cred"
    Start_Menu($select)
}

function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    *************************************************
    *           Right Fax Ownership Menu            *
    *************************************************
    *   Before Submitting your Set Owner            *
    *   request make sure you have updated the      *
    *   _InputList_Servers.txt file located in the  *
    *   Ownership directory.                        *
    *                                               *                                  
    *   Type 1 To Submit Your Set Ownership Request *                  
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit or Enter to Continue        *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){Ownership($addorchange)}
    if ($addorchange -like "Main"){Mastermenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)