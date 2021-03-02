function MasterMenu{
    clear-host
    Invoke-expression "& .\Master_Menu.PS1 -Credential $Cred"
    Start_Menu($select)
}

function ServerBuild{
    Clear-Host
    Write-Host "
                *** Enter Build Selection ***
    
    "
    
    $EN = ""
    $PR = ""
    $AP = ""

    $EN = Read-Host -Prompt '      Enter DEV 
      Enter Stage
      Enter Prod '
    
    Write-Host " 
    
    "
    $PR = Read-Host -Prompt 'For Collective 
      Enter BAI-IN1
      Enter BAI-IN2
      Enter BAI-IN3
      Enter BAI-IN4
      Enter BAI-OUT1
      Enter BAI-OUT2
      Entere BAI-OUT3
      Enter BAI-OUT4
      Enter BAI-OUT5
      Enter BAI-OUT6
      Enter FAX-A
      Enter FAX-B'
    
      Write-Host " 
    
    "
    $AP = Read-Host -Prompt '      Enter APP
      Enter RDT
      Enter WEB
      Enter Task'
    
      Write-Host " 
    
    "

    If ($AP -like 'APP'){
      Set-Location -Path "E:\SC\Rightfax-Kiosk\Adhoc\$EN\$PR\$AP\"
      $Command = "E:\SC\Rightfax-Kiosk\Adhoc\$EN\$PR\$AP\BAIAPPIN.PS1 -Creden1tial $Cred"
      Invoke-expression -Command $Command
      Pause
      clear-host
      Start_Menu($select)
    }

    If ($AP -like 'RDT'){
      Set-Location -Path "E:\SC\Rightfax-Kiosk\Adhoc\$EN\$PR\$AP\" 
      $Command = "E:\SC\Rightfax-Kiosk\$EN\$PR\$AP\_RunTF.PS1 -Credential $Cred"
      Invoke-expression -Command $Command
      Pause
      clear-host
      Start_Menu($select)
    }

    If ($AP -like 'Task'){
      Set-Location -Path "E:\SC\Rightfax-Kiosk\Adhoc\$EN\$PR\$AP\" 
      $Command = "E:\SC\Rightfax-Kiosk\$EN\$PR\$AP\_RunTF.PS1 -Credential $Cred"
      Invoke-expression -Command $Command
      Pause
      clear-host
      Start_Menu($select)
    } 

    If ($AP -like 'WEB'){
      Set-Location -Path "E:\SC\Rightfax-Kiosk\Adhoc\$EN\$PR\$AP\" 
      $Command = "E:\SC\Rightfax-Kiosk\$EN\$PR\$AP\_RunTF.PS1 -Credential $Cred"
      Invoke-expression -Command $Command
      Pause
      clear-host
      Start_Menu($select)
    }
}

function Start_Menu{
    Write-Host '
    *************************************************
    *           Right Fax Ad Hoc Server Build       *
    *************************************************
    *   Type 1 To Start the Build                   *
    *                                               *
    *   Type MAIN to Return to main Menu            *
    *                                               *
    *   Press X to Exit                             *
    *************************************************'
    
    
    $addorchange = Read-Host -Prompt 'Enter Choice'
    if ($addorchange -like "1"){ServerBuild($addorchange)}
    if ($addorchange -like "Main"){MasterMenu($addorchange)}
    if ($addorchange -like "x"){BYEING($addorchange)}
    
    }
    
    Function BYEING{ 
    
    Write-Host "Exiting Right Fax System Install"
        Break
    }
    
    Start_Menu($select)
 