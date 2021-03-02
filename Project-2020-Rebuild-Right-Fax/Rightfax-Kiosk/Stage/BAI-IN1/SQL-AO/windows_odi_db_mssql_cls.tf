resource "optumvm_dbclustermssql" "windows_odi_db_mssql_cls" {

# ----------------------------------------------------------------------------------------------------------------------
# Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# ----------------------------------------------------------------------------------------------------------------------
  count = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_count}"   
  # for_each = toset(["", ""])   
  #   # Enter server index name as quoted comma delimited values for state file
  #   # Example: ["clsOne", "clsTwo", "clsThree"] put 3 servers in statefile file indexed to clsOne, clsTwo and clsThree
# ----------------------------------------------------------------------------------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu               = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_cpu}"         
  memory            = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_memory}" 
  requestedfor      = "${var.tf1211}${var.TFVAR_odi_requestedfor}"
  sharedaccessgroup = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"

  # Edited by builder: ALL DB Specific Items
  # image                = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_image}"  Uses sqlserverdbversion to determine WIN OS version 
  lobname                = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_lobname}"
  sqlserverdbversion     = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_sqlserverdbversion}"
  dbcollation            = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_dbcollation}"
  sqlserverdatabasename  = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_sqlserverdatabasename}"
  databasesize           = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_databasesize}"
  sqlserverdatabaseowner = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_sqlserverdatabaseowner}"
  dbaccessgroup          = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_dbaccessgroup}"
  phi                    = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_phi}"
  pii                    = "${var.tf1211}${var.TFVAR_windows_db_mssql_cls_pii}"

  # Common values across all RSOS
  askid             = "${var.tf1211}${var.TFVAR_odi_askid}"
  targetenv         = "${var.tf1211}${var.TFVAR_odi_targetenv}"
  datacenter        = "${var.tf1211}${var.TFVAR_odi_datacenter}"
  availabilityzone  = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
  networkzone       = "${var.tf1211}${var.TFVAR_odi_networkzone}"
  interfacezone     = "${var.tf1211}${var.TFVAR_odi_interfacezone}"
  vraenv            = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"
}
  
# ---------------------------------------------------------------------------------
# Servername is a returned as an array of servernames, 1st one is primary node
# ---------------------------------------------------------------------------------
# output "windows_odi_db_mssql_cls_server_info" {
#   value = {
#     for instance in optumvm_dbclustermssql.windows_odi_db_mssql_cls:
#     instance.servername => instance.*
#   }
# }

output "windows_odi_db_mssql_cls_servernames" {
  value = "${optumvm_dbclustermssql.windows_odi_db_mssql_cls.*.servername}"
}