function IN1Stage{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN1\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN1\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN1\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN1\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN1\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}

function IN2Stage{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN2\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN2\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN2\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN2\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-IN2\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}

function OUT1Stage{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-OUT1\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-OUT1\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-OUT1\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-OUT1\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\STAGE\BAI-OUT1\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}

function IN1Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN1\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN1\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN1\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN1\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN1\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
} 

function IN2Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN2\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN2\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN2\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN2\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN2\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
} 

function IN3Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN3\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN3\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN3\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN3\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN3\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
} 

function IN4Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN4\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN4\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN4\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN4\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-IN4\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}  

function OUT1Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT1\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT1\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT1\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT1\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT1\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
} 

function OUT2Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT2\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT2\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT2\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT2\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT2\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
} 

function OUT3Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT3\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT3\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT3\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT3\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT3\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}

function OUT4Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT4\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT4\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT4\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT4\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT4\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
} 

function OUT5Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT5\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT5\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT5\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT5\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT5\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    Invoke-expression "& .\UCodeMaster.PS1 -Credential $Cred -Argument $argumentList"
    clear-host
    Start_Menu($select)
}  

function OUT6Prod{
    $Serversfile = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT6\App\servers.txt
    $SAPP = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT6\App\servers.txt
    $ServersRDT = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT6\RDT\servers.txt
    $ServersWEB = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT6\WEB\servers.txt
    $ServersTASK = Get-Content E:\SC\Rightfax-Kiosk\server-text-files\AdHoc\PROD\BAI-OUT6\TASK\servers.txt
    $argumentList = @(
        $Serversfile
        $SAPP
        $ServersRDT
        $ServersWEB
        $ServersTASK 
    )
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
} 

function Master_Menu{
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    ************************************************************************************
    *                         Right Fax BAI Select Configuration Menu                  *        
    *                                       For AdHoc Builds                           *
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
    *         Type 6 for Prod                *                                         *
    *                                        *                                         *
    *         Collective OUT1                *                                         *
    *        Type 7 for Stage                *                                         *
    *        Type 8 for Prod                 *   Type Main to Return to main Menu         *
    *                                        *                                         *
    *          Collective OUT2               *   Press X to Exit                       *
    *        Type 9 for Prod                 *                                         *
    ************************************************************************************
    ' 
   
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){IN1Stage($addorchange)}
    if ($addorchange -like "2"){IN1Prod($addorchange)}
    if ($addorchange -like "3"){IN2Stage($addorchange)}
    if ($addorchange -like "4"){IN2Prod($addorchange)}
    if ($addorchange -like "5"){IN3Prod($addorchange)}
    if ($addorchange -like "6"){IN4Prod($addorchange)} 
    if ($addorchange -like "7"){OUT1Stage($addorchange)}
    if ($addorchange -like "8"){OUT1Prod($addorchange)}
    if ($addorchange -like "9"){OUT2Prod($addorchange)}
    if ($addorchange -like "10"){OUT3Prod($addorchange)}
    if ($addorchange -like "11"){OUT4Prod($addorchange)}
    if ($addorchange -like "12"){OUT5Prod($addorchange)}
    if ($addorchange -like "13"){OUT6Prod($addorchange)}
    if ($addorchange -like "Main"){Master_Menu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)
    