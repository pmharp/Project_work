$cred = Get-Credential pharp101 
$s = New-PSSession -computerName apved55310 -credential $cred
Invoke-Command -Session $s -Scriptblock {New-Item -type file e:\drop folder\build folder vm\checkout script\inspec_remote_bramch_v2.exe}
Remove-PSSession $s