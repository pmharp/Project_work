$Credentials = Get-Credential
 pause
 #  Converts all raw disks to basic on the given server FQDH.ms.ds.uhc.com
 #  Then Assigned a driveletter, and a NewFileSystemLabel to each parition number for the given server FQDN.ms.ds.uhc.com
 #
 #  copy and paste at end of file the get-disk line and any new-partition lines needed for each server needed to configure
 #  Once copied make sure to update the FQDN DriveLetter and NewFileSystemLAbel values for each line
 #  Can also put a "pause" line inbetween each server block or at end to help when running script
 #
 invoke-command -computername Apvep72132.ms.ds.uhc.com -ScriptBlock {get-disk | Where-Object partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT -PassThru } -Credential $Credentials
 #  configures partition 2 as E drive
 invoke-command -computername Apvep72132.ms.ds.uhc.com -ScriptBlock {new-partition 2 -DriveLetter 'E' -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'App' -Confirm:$false } -backend winrm -Credential $Credentials
 pause
 #  configures partition 3 as F drive
 #invoke-command -computername Wevet68399.ms.ds.uhc.com -ScriptBlock {new-partition 3 -DriveLetter 'F' -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'f_app_2gb' -Confirm:$false } -backend winrm -Credential $Credentials
 #pause
 invoke-command -computername Apvep72133.ms.ds.uhc.com -ScriptBlock {get-disk | Where-Object partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT -PassThru } -Credential $Credentials
 #  configures partition 2 as E drive
 invoke-command -computername Apvep72133.ms.ds.uhc.com -ScriptBlock {new-partition 2 -DriveLetter 'E' -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'App' -Confirm:$false } -backend winrm -Credential $Credentials
 pause
 invoke-command -computername Apvep72186.ms.ds.uhc.com -ScriptBlock {get-disk | Where-Object partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT -PassThru } -Credential $Credentials
 #  configures partition 2 as E drive
 invoke-command -computername Apvep72186.ms.ds.uhc.com -ScriptBlock {new-partition 2 -DriveLetter 'E' -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'App' -Confirm:$false } -backend winrm -Credential $Credentials
 pause
 invoke-command -computername Apvep72187.ms.ds.uhc.com -ScriptBlock {get-disk | Where-Object partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT -PassThru } -Credential $Credentials
 #  configures partition 2 as E drive
 invoke-command -computername Apvep72187.ms.ds.uhc.com -ScriptBlock {new-partition 2 -DriveLetter 'E' -UseMaximumSize | Format-Volume -FileSystem NTFS -NewFileSystemLabel 'App' -Confirm:$false } -backend winrm -Credential $Credentials
 pause