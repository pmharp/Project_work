resource "optumvm_mysqlvm" "mysql_1" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumvm/vm_mySQL.html#mysql-server-matrix
  # Edited by builder: Can mod for Day 2 Actions
  cpu                      = "1"
  memory                   = "2"
  reasonchangeram          = "" # Only needed when changing memory after build.  Options: "both", "buffered pool", "connections"
  requestedfor             = "${var.tf1211}${var.TFVAR_requestedfor}@ms.ds.uhc.com"
  vrasharedaccessgroup     = "${var.tf1211}${var.TFVAR_vrasharedaccessgroup}"

  # Edited by builder: ALL DB Specific Items
  lobname              = ""
  databasedescription  = ""
  mysqldbversion       = "5.7"
  mysqldatabasename    = ""
  mysqldatabasesize    = ""
  mysqldatabaseowner   = ""
  phi                  = "No"
  pii                  = "No"

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

output "mysql_1_servername" {
  value = "${optumvm_mysqlvm.mysql_1.servername}"
}
output "mysql_1_ipaddress" {
  value = "${optumvm_mysqlvm.mysql_1.ipaddress}"
}
output "mysql_1_cpu" {
  value = "${optumvm_mysqlvm.mysql_1.cpu}"
}
output "mysql_1_memory" {
  value = "${optumvm_mysqlvm.mysql_1.memory}"
}
output "mysql_1_targetenv" {
  value = "${optumvm_mysqlvm.mysql_1.targetenv}"
}