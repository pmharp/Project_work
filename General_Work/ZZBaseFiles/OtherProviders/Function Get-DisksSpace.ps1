Function Get-DisksSpace            
{            
<# .SYNOPSIS Grabs Hard Drive & Mount Point space information. 
.DESCRIPTION Grabs Hard Drive & Mount Point space information. 
.PARAMETER serverName Accepte 1 or more servernames, up to 50 at once. 
.INPUTS Accepts pipline input of server names 
.OUTPUTS SystemName, Name, SizeIn[KB|MB|GB], FreeIn[KB|MB|GB], PercentFree, Label 
.NOTES None. 
.LINK None. 
.EXAMPLE PS> Get-DisksSpace localhost "MB" | ft
.EXAMPLE
Get-DisksSpace localhost | Out-GridView
.EXAMPLE
Get-DisksSpace localhost | ft
.EXAMPLE
Get-DisksSpace localhost | where{$_.PercentFree -lt 20} | Format-Table -AutoSize
#>            
[cmdletbinding()]            
param            
(            
<#[Parameter(Mandatory)]#>            
[Parameter(mandatory,ValueFromPipeline = $true,ValueFromPipelinebyPropertyname = $true)]            
[ValidateCount(1,50)]            
[string[]]$Servername='localhost',            
[Parameter()]            
[ValidateSet('KB', 'MB', 'GB')]            
[string]$unit= "GB"            
)            
process {            
$measure = "1$unit"            
Get-WmiObject -computername $serverName -query "
select SystemName, Name, DriveType, FileSystem, FreeSpace, Capacity, Label
from Win32_Volume
where DriveType = 2 or DriveType = 3" `
| select SystemName ,            
Name ,            
@{Label="SizeIn$unit";Expression={"{0:n2}" -f($_.Capacity/$measure)}} ,            
@{Label="FreeIn$unit";Expression={"{0:n2}" -f($_.freespace/$measure)}} ,            
@{Label="PercentFree";Expression={"{0:n2}" -f(($_.freespace / $_.Capacity) * 100)}} ,            
Label            
}            
}#Get-DisksSpace

*****************************************

Check Mount Point Free Space Powershell

###mount point space
$TotalGB = @{Name="Capacity(GB)";expression={[math]::round(($_.Capacity/ 1073741824),2)}}
$FreeGB = @{Name="FreeSpace(GB)";expression={[math]::round(($_.FreeSpace / 1073741824),2)}}
$FreePerc = @{Name="Free(%)";expression={[math]::round(((($_.FreeSpace / 1073741824)/($_.Capacity / 1073741824)) * 100),0)}}

function get-mountpoints {
$volumes = Get-WmiObject -computer $server win32_volume | Where-object {$_.DriveLetter -eq $null}
$volumes | Select SystemName, Label, $TotalGB, $FreeGB, $FreePerc | Format-Table -AutoSize
}

$servers = "TARALON06SQL01P"

foreach ($server in $servers){
get-mountpoints
}

**************************************

Function Create-MountPoint
{
    #Initialize volume, create partition, mount as NTFS Mount Point, and format as NTFS Volume
    Param($Servername,$VolumeName,$VolumeSize,$Path,$CimSession)
        $VolumeSizeGB = [string]$VolumeSize + "GB"
    
    $partition = Get-Disk -CIMSession $CimSession | Where-Object {($_.partitionstyle -eq "raw") -and ($_.size -eq $VolumeSizeGB)} | Initialize-Disk -PartitionStyle GPT -PassThru |  New-Partition -UseMaximumSize -AssignDriveLetter:$False 
    
    $disknumber = $partition.DiskNumber
    $partitionnumber = $partition.partitionnumber
    $diskID = $partition.diskID

    Get-Partition -DiskNumber $disknumber -PartitionNumber $partitionnumber -CimSession $CimSession | Format-Volume -AllocationUnitSize 64KB -FileSystem NTFS -NewFileSystemLabel $VolumeName -Confirm:$false 
    Add-PartitionAccessPath -CimSession $CimSession -DiskNumber $disknumber -PartitionNumber $partitionnumber -AssignDriveLetter:$False
    Add-PartitionAccessPath -CimSession $CimSession -DiskNumber $disknumber -PartitionNumber $partitionnumber -AccessPath $Path 
    Set-Partition -CimSession $CimSession -DiskNumber $disknumber -PartitionNumber $partitionnumber -NoDefaultDriveLetter:$true
}

