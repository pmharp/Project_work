function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIIN1Stage{
    clear-host
    Invoke-expression "& .\BAI-Stage-IN1.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIIN2Stage{
    clear-host
    Invoke-expression "& .\BAI-Stage-IN2.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT1Stage{
    clear-host
    Invoke-expression "& .\BAI-Stage-OUT1.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIIN1Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-IN1.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIIN2Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-IN2.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIIN3Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-IN3.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIIN4Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-IN4.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT1Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-OUT1.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT2Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-OUT2.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT3Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-OUT3.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT4Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-OUT4.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT5Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-OUT5.PS1 -Credential $Cred"
    Start_Menu($select)
}

function BAIOUT6Prod{
    clear-host
    Invoke-expression "& .\BAI-Prod-OUT6.PS1 -Credential $Cred"
    Start_Menu($select)
}


function Start_Menu{
    clear-host
    Write-Host '
    ************************************************************************************
    *                         Right Fax BAI Build Menu                                 *        
    *                                                                                  *
    ************************************************************************************
    *          Collective IN1                *     Collective OUT3                     *
    *         Type 1 for Stage               *    Type 10 for Prod                     *
    *         Type 2 for Prod                *                                         *
    *                                        *     Collective OUT4                     *
    *          Collective IN2                *    Type 11 for Prod                     *
    *         Type 3 for Stage               *                                         *
    *         Type 4 for Prod                *     Collective OUT5                     *
    *                                        *    Type 12 for Prod                     *
    *          Collective IN3                *                                         *
    *         Type 5 for Prod                *     Collective OUT6                     *
    *                                        *    Type 13 for Prod                     *
    *          Collective IN4                *                                         *
    *         Type 6 for Prod                *   NAS Server (Need only 1 for BAI)      *
    *                                        *    Type 14 for Non-Prod                 *
    *         Collective OUT1                *    Type 15 for Prod                     *
    *        Type 7 for Stage                *                                         *
    *        Type 8 for Prod                 *   Type MAIN to Return to main Menu      *
    *                                        *                                         *
    *          Collective OUT2               *   Press X to Exit                       *
    *        Type 9 for Prod                 *                                         *
    ************************************************************************************
    ' 
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){BAIIN1Stage($addorchange)}
    if ($addorchange -like "2"){BAIIN1Prod($addorchange)}
    if ($addorchange -like "3"){BAIIN2Stage($addorchange)}
    if ($addorchange -like "4"){BAIIN2Prod($addorchange)}
    if ($addorchange -like "5"){BAIIN3Prod($addorchange)}
    if ($addorchange -like "6"){BAIIN4Prod($addorchange)}
    if ($addorchange -like "7"){BAIOUT1Stage($addorchange)}
    if ($addorchange -like "8"){BAIOUT1Prod($addorchange)}
    if ($addorchange -like "9"){BAIOUT2Prod($addorchange)}
    if ($addorchange -like "10"){BAIOUT3Prod($addorchange)}
    if ($addorchange -like "11"){BAIOUT4Prod($addorchange)}
    if ($addorchange -like "12"){BAIOUT5Prod($addorchange)}
    if ($addorchange -like "13"){BAIOUT6Prod($addorchange)}
    
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    }
    
    Function BYEING{ 
    
        Write-Host "Exiting Right Fax System Install"
            Break
        }

    Start_Menu($select)