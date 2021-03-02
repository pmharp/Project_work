$w_usr_id = Read-Host -Prompt 'Primary Windows MS ID'
$w_usr_pwd = Read-Host -Prompt 'Primary Windows MS Password' -AsSecureString
$w_Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $w_usr_id, $w_usr_pwd
$w_extract_pwd = $w_Credentials.GetNetworkCredential().Password

$tfPlan = "terraform plan -input=true -var 'PriMsId=${w_usr_id}' -var 'PriMsIdPwd=${w_extract_pwd}'"

$tfApply = "terraform apply -var 'PriMsId=${w_usr_id}' -var 'PriMsIdPwd=${w_extract_pwd}' -auto-approve"

#terraform init -input=false
terraform init

terraform -v
Invoke-Expression $tfPlan

write-host -nonewline "Confirm Terraform plan above. Would you like to Continue? (Y/N) "
$response = read-host
if ( $response -ne "Y" ) { exit }
else { Invoke-Expression $tfApply }