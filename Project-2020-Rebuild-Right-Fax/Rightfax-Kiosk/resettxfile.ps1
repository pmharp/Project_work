function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAI{
    clear-host
    Invoke-expression "& .\BAIresettxfile.PS1 -Credential $Cred"
    Start_Menu($select)
}

function FAX{
    clear-host
    Invoke-expression "& .\FAXresettxfile.PS1 -Credential $Cred"
    Start_Menu($select)
}

function AHBAI{
    clear-host
    Invoke-expression "& .\AHresettxfile.PS1 -Credential $Cred"
    Start_Menu($select)
}

function AHFAX{
    clear-host
    Invoke-expression "& .\AHFAXresettxfile.PS1 -Credential $Cred"
    Start_Menu($select)
}

function DEV{
    clear-host
    Invoke-expression "& .\DEVresettxfile.PS1 -Credential $Cred"
    Start_Menu($select)
}

function SAndbox{
    clear-host
    Invoke-expression "& .\SBresettxfile.PS1 -Credential $Cred"
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    ************************************
    *    Right Fax Clear Text Menu     *        
    *                                  *
    ************************************
    *                                  *
    *         Type 1 for BAI           *
    *         Type 2 for Fax           *
    *         Type 3 for AdHoc BAI     *
    *         Type 4 for AdHoc Fax     *
    *         Type 5 for DEV           *
    *         Type 6 for Sandbox       *
    *                                  *
    *       Type Main to for Main Menu *
    *                                  *
    *         Press X to Exit          *
    *                                  *
    ************************************
    '   
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){BAI($addorchange)}
    if ($addorchange -like "2"){FAX($addorchange)}
    if ($addorchange -like "3"){AHBAI($addorchange)}
    if ($addorchange -like "4"){AHFAX($addorchange)}
    if ($addorchange -like "5"){DEV($addorchange)}
    if ($addorchange -like "6"){SANDBOX($addorchange)} 
    if ($addorchange -like "Main"){Mastermenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)
 