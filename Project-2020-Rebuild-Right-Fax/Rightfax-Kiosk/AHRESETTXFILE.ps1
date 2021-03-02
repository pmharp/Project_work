function Master_Menu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function IN1Stage{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\Web\servers.txt" -Force
    Start_Menu($select)
}

function IN2Stage{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\Web\servers.txt" -Force
    Start_Menu($select)
}
function OUT1Stage{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\Web\servers.txt" -Force
    Start_Menu($select)
}

function IN1Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\Web\servers.txt" -Force
    Start_Menu($select)
}

function IN2Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\Web\servers.txt" -Force
    Start_Menu($select)
}

function IN3Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\Web\servers.txt" -Force
    Start_Menu($select)
}

function IN4Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\Web\servers.txt" -Force
    Start_Menu($select)
}

function OUT1Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\Web\servers.txt" -Force
    Start_Menu($select)
}

function OUT2Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\Web\servers.txt" -Force
    Start_Menu($select)
}

function OUT3Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\Web\servers.txt" -Force
    Start_Menu($select)
}

function OUT4Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\Web\servers.txt" -Force
    Start_Menu($select)
}

function OUT5Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\Web\servers.txt" -Force
    Start_Menu($select)
}

function OUT6Prod{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\Web\servers.txt" -Force
    Start_Menu($select)
}

function BAIALL{
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN1\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-IN2\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Stage\BAI-OUT1\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN1\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN2\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN3\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-IN4\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT1\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT2\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT3\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT4\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT5\Web\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\APP\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\RDT\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\Task\servers.txt" -Force
    new-Item -ItemType "file" -Path "E:\SC\Rightfax-Kiosk\Server-Text-Files\AdHoc\Prod\BAI-OUT6\Web\servers.txt" -Force
    Start_Menu($select)
}

function FAXAB{
    Invoke-expression "& .\AHFAXRESETTXFILE.PS1 -Credential $Cred"
    clear-host
    Start_Menu($select)
}

function Start_Menu{
    Write-Host '
    ************************************************************************************
    *                         AdHoc Right Fax Server Build Text file Reset             *        
    *                                            For BAI Menu                          *
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
    *         Type 6 for Prod                *    Type 14 for Enterprise Fax           *
    *                                        *                                         *
    *         Collective OUT1                *    Type 15 to Reset All BAI             *
    *        Type 7 for Stage                *                                         *
    *        Type 8 for Prod                 *   Type Main to Return to main Menu      *
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
    if ($addorchange -like "14"){FAXAB($addorchange)}
    if ($addorchange -like "15"){BAIALL($addorchange)}
    if ($addorchange -like "Main"){Master_Menu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)
    
 