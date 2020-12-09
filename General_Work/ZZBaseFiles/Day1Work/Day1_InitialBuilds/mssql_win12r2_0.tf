resource "optumvm_sqlservervm" "mssql_win12r2_0" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumvm/vm_msSQL.html#ms-sql-server-vm-configuration
  # Edited by builder: Can mod for Day 2 Actions
  cpu                      = "2"
  memory                   = "6"
  requestedfor             = "${var.tf1211}${var.TFVAR_requestedfor}@ms.ds.uhc.com"
  vrasharedaccessgroup     = "${var.tf1211}${var.TFVAR_vrasharedaccessgroup}"

  # Edited by builder: ALL DB Specific Items
  lobname                  = ""
  databasedescription      = ""
  forazurecapacity         = "No"
  sqlserverexceptionfactor = "Business"
  exceptionexplain         = ""
  sqlserverdbversion       = "2016"
  dbcollation              = "Latin1_General_CI_AS"
  sqlserverdatabasename    = ""
  databasesize             = ""
  sqlserverdatabaseowner   = ""
  dbaccessgroup            = ""
  phi                      = "No"
  pii                      = "No"
  foragileteam             = "No"
  agilitygroup             = "Not Applicable"

  # Edited by builder: CANNOT MOD for day 2
  vradescription          = "${var.tf1211}${var.TFVAR_vradescription}"

  # Common values across all RSOS
  askid                = "${var.tf1211}${var.TFVAR_askid}"
  ppmoprojnum          = "${var.tf1211}${var.TFVAR_ppmoprojnum}"
  targetenv            = "${var.tf1211}${var.TFVAR_targetenv}"
  datacenter           = "${var.tf1211}${var.TFVAR_datacenter}"
  resiliencyzone       = "${var.tf1211}${var.TFVAR_resiliencyzone}"
  networkzone          = "${var.tf1211}${var.TFVAR_networkzone}"
  interfacezone        = "${var.tf1211}${var.TFVAR_interfacezone}"
  drcode               = "${var.tf1211}${var.TFVAR_drcode}"
  drrto                = "${var.tf1211}${var.TFVAR_drrto}"
  vrareasons           = "${var.tf1211}${var.TFVAR_vrareasons}"
  sedsupport           = "${var.tf1211}${var.TFVAR_sedsupport}"
  vraenv               = "${var.tf1211}${var.TFVAR_vraenv}"
  useserviceaccount    = "${var.tf1211}${var.TFVAR_useserviceaccount}" 

  # Maintenance Windows name value pairs
  maintenancegroup      = "${var.tf1211}${var.TFVAR_maintenancegroup}"
  maintenancerebootday  = "${var.tf1211}${var.TFVAR_maintenancerebootday}"
  maintenancereboothour = "${var.tf1211}${var.TFVAR_maintenancereboothour}" 

  # DO NOT EDIT: Pulled from TFVars file and ps file as input
  # RSO Specific Entries
  paasagree                = "yes"
}
  
output "mssql_win12r2_0_servername" {
  value = "${optumvm_sqlservervm.mssql_win12r2_0.servername}"
}
output "mssql_win12r2_0_ipaddress" {
  value = "${optumvm_sqlservervm.mssql_win12r2_0.ipaddress}"
}
output "mssql_win12r2_0_cpu" {
  value = "${optumvm_sqlservervm.mssql_win12r2_0.cpu}"
}
output "mssql_win12r2_0_memory" {
  value = "${optumvm_sqlservervm.mssql_win12r2_0.memory}"
}
output "mssql_win12r2_0_targetenv" {
  value = "${optumvm_sqlservervm.mssql_win12r2_0.targetenv}"
}