resource "optumvm_dbclustermysql" "linux_odi_db_mysql_cls" {

# ----------------------------------------------------------------------------------------------------------------------
# Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# ----------------------------------------------------------------------------------------------------------------------
  count = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_count}"   
  # for_each = toset(["", ""])   
  #   # Enter server index name as quoted comma delimited values for state file
  #   # Example: ["clsOne", "clsTwo", "clsThree"] put 3 servers in statefile file indexed to clsOne, clsTwo and clsThree
# ----------------------------------------------------------------------------------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu               = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_cpu}"         
  memory            = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_memory}"      
  requestedfor      = "${var.tf1211}${var.TFVAR_odi_requestedfor}"
  sharedaccessgroup = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"
  
 # Edited by builder: ALL DB Specific Items
  image             = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_image}"
  lobname           = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_lobname}"
  mysqldbversion    = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_mysqldbversion}"
  mysqldatabasename = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_mysqldatabasename}"
  databasesize      = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_databasesize}"
  phi               = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_phi}"
  pii               = "${var.tf1211}${var.TFVAR_linux_db_mysql_cls_pii}"

  # Common values across all RSOS
  askid            = "${var.tf1211}${var.TFVAR_odi_askid}"
  targetenv        = "${var.tf1211}${var.TFVAR_odi_targetenv}"
  datacenter       = "${var.tf1211}${var.TFVAR_odi_datacenter}"
  availabilityzone = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
  networkzone      = "${var.tf1211}${var.TFVAR_odi_networkzone}"
  interfacezone    = "${var.tf1211}${var.TFVAR_odi_interfacezone}"
  vraenv           = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"
}

# ---------------------------------------------------------------------------------
# Servername is a returned as an array of servernames, 1st one is primary node
# ---------------------------------------------------------------------------------
# output "linux_odi_db_mysql_cls_server_info" {
#   value = {
#     for instance in optumvm_dbclustermysql.linux_odi_db_mysql_cls:
#     instance.servername => instance.*
#   }
# }

output "linux_odi_db_mysql_cls_servernames" {
  value = "${optumvm_dbclustermysql.linux_odi_db_mysql_cls.*.servername}"
}