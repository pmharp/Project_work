function decom{
    Invoke-expression -Command "C:\opscode\chef-repo\SC\Decom\odi_decommissionvm.PS1 -List -File -Log -Credential $Cred"
    Pause
    clear-host
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
    *           Right Fax Decom Menu                *
    *************************************************
    *   Before Submitting your Decommission         *
    *   request make sure you have updated the      *
    *   _InputList_Servers.txt file located in the  *
    *   Decom directory.                            *
    *                                               *                                  
    *   Type 1 To Submit Your Decom Request         *                  
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit or Enter to Continue        *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){Decom($addorchange)}
    if ($addorchange -like "Main"){Mastermenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
}
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)