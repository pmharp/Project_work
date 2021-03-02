$Serverdata = Get-Content terraform.tfstate
foreach($Server in $Serverdata){ 
    $s = $Server
    Write-host $S 
}    