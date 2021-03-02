function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function SBIN1{
    Invoke-expression "& .\SB-IN1.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBIN2{
    Invoke-expression "& .\SB-IN2.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBIN3{
    Invoke-expression "& .\SB-IN3.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBIN4{
    Invoke-expression "& .\SB-IN4.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBOUT1{
    Invoke-expression "& .\SB-OUT1.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBOUT2{
    Invoke-expression "& .\SB-OUT2.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBOUT3{
    Invoke-expression "& .\SB-OUT3.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBOUT4{
    Invoke-expression "& .\SB-OUT4.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBOUT5{
    Invoke-expression "& .\SB-OUT5.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBOUT6{
    Invoke-expression "& .\SB-OUT6.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBFAXA{
    Invoke-expression "& .\SB-FAXA.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function SBFAXB{
    Invoke-expression "& .\SB-FAXB.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}


function Start_Menu{
    Write-Host '
    ************************************************************************************
    *                         Right Fax Sandbox Build Menu                             *        
    *                                                                                  *
    ************************************************************************************
    *          Collective IN1                *     Collective OUT3                     *
    *         Type 1                         *    Type 7                               *
    *                                        *                                         *
    *          Collective IN2                *     Collective OUT4                     *
    *         Type 2                         *    Type 8                               *
    *                                        *                                         *
    *          Collective IN3                *     Collective OUT5                     *
    *         Type 3                         *    Type 9                               *
    *                                        *                                         *
    *          Collective IN4                *     Collective OUT6                     *
    *          Type 4                        *    Type 10                              *
    *                                        *                                         *
    *          Collective OUT1               *      Collective FAX A and B             *
    *          Type 5                        *     Type 11 for FAX A                   *
    *                                        *     Type 12 for FAX B                   *
    *          Collective OUT2               *                                         *
    *          Type 6                        *   Type MAIN to Return to main Menu      *
    *                                        *                                         *
    *                                        *   Press X to Exit                       *
    *                                        *                                         *
    ************************************************************************************
    ' 
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){SBIN1($addorchange)}
    if ($addorchange -like "2"){SBIN2($addorchange)}
    if ($addorchange -like "3"){SBIN3($addorchange)}
    if ($addorchange -like "4"){SBIN4($addorchange)}
    if ($addorchange -like "5"){SBOUT1($addorchange)}
    if ($addorchange -like "6"){SBOUT2($addorchange)}
    if ($addorchange -like "7"){SBOUT3($addorchange)}
    if ($addorchange -like "8"){SBOUT4($addorchange)}
    if ($addorchange -like "9"){SBOUT5($addorchange)}
    if ($addorchange -like "10"){SBOUT6($addorchange)}
    if ($addorchange -like "11"){SBFAXA($addorchange)}
    if ($addorchange -like "12"){SBFAXB($addorchange)} 
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)