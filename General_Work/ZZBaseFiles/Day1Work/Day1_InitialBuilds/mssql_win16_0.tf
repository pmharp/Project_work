resource "optumvm_dbservermssql" "mssql_win16_0" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumvm/vm_msSql_win16.html#ms-sql-server-vm-configuration
  # Edited by builder: Can mod for Day 2 Actions
  cpu                      = "2"            # Options are 2,4,6,8 Only
  memory                   = "8"
  requestedfor             = "${var.tf1211}${var.TFVAR_requestedfor}"
  vrasharedaccessgroup     = "${var.tf1211}${var.TFVAR_vrasharedaccessgroup}"

#   # Edited by builder: ALL DB Specific Items
  lobname                  = ""      
  sqlserverdbversion       = "2016"                                      
  dbcollation              = "Latin1_General_CI_AS"
  sqlserverdatabasename    = ""
  databasesize             = ""
  sqlserverdatabaseowner   = ""
  dbaccessgroup            = ""
  phi                      = "No"                                         
  pii                      = "No"                                         

#   # Common values across all RSOS
  askid                = "${var.tf1211}${var.TFVAR_askid}"
  targetenv            = "${var.tf1211}${var.TFVAR_targetenv}"
  datacenter           = "${var.tf1211}${var.TFVAR_datacenter}"
  resiliencyzone       = "${var.tf1211}${var.TFVAR_resiliencyzone}"
  networkzone          = "${var.tf1211}${var.TFVAR_networkzone}"
  interfacezone        = "${var.tf1211}${var.TFVAR_interfacezone}"
  drcode               = "${var.tf1211}${var.TFVAR_drcode}"
  sedsupport           = "${var.tf1211}${var.TFVAR_sedsupport}"     
  vraenv               = "${var.tf1211}${var.TFVAR_vraenv}"
  useserviceaccount    = "${var.tf1211}${var.TFVAR_useserviceaccount}" 

#   # DO NOT EDIT: Pulled from TFVars file and ps file as input
#   # RSO Specific Entries
  iaasagree = "yes"                  # Needed due to requesting server as DB not paas DB server
  rsoname   = "win2016fs"            # Needed due to requesting server as DB not paas DB server
}
  
output "mssql_win16_0_servername" {
  value = "${optumvm_dbservermssql.mssql_win16_0.servername}"
}
output "mssql_win16_0_ipaddress" {
  value = "${optumvm_dbservermssql.mssql_win16_0.ipaddress}"
}
output "mssql_win16_0_cpu" {
  value = "${optumvm_dbservermssql.mssql_win16_0.cpu}"
}
output "mssql_win16_0_memory" {
  value = "${optumvm_dbservermssql.mssql_win16_0.memory}"
}
output "mssql_win16_0_targetenv" {
  value = "${optumvm_dbservermssql.mssql_win16_0.targetenv}"
}