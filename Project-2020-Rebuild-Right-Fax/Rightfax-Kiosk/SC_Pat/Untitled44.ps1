Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $SCinitialDirectory
    $OpenFileDialog.filter = "TXT (*.txt)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null

    $OpenFileDialog2 = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog2.initialDirectory = $xmlinitialDirectory
    $OpenFileDialog2.filter = "XML (*.xml)| *.XML"
    $OpenFileDialog2.ShowDialog() | Out-Null

   Write-Host -ForegroundColor Green "$openFileDialog"
    Write-Host -ForegroundColor Green "$openFileDialog2"
}
Get-FileName