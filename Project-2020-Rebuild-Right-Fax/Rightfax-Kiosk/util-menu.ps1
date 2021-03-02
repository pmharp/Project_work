function Decom{
    clear-host
    Invoke-expression "& .\Server-Decom.ps1 -Credential $Cred"
    Start_Menu($select)
}

function Ownership{
    clear-host
    Invoke-expression "& .\Owner.ps1 -Credential $Cred"
    Start_Menu($select)
}

function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function resettxt {
    clear-host
    Invoke-expression "& .\ResetTXFile.ps1 -Credential $Cred"
    Start_Menu($select)
  }
  

function Start_Menu{
    Write-Host '
    *************************************************
    *           Right Fax Utility Menu              *
    *************************************************
    *   Type 1 Server Decommission                  *
    *                                               *
    *   Type 2 Change Ownership                     *                  
    *                                               *
    *   Type 3 To Clear Server Build Text Files     *
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){Decom($addorchange)}
    if ($addorchange -like "2"){ownership($addorchange)}
    if ($addorchange -like "2"){ownership($addorchange)}
    if ($addorchange -like "3"){resettxt($addorchange)}
    if ($addorchange -like "Main"){Mastermenu.ps1($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)
    