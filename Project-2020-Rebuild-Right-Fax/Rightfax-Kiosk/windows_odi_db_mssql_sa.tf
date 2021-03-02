resource "optumvm_dbservermssql_odi" "windows_odi_db_mssql_sa" {

# ----------------------------------------------------------------------------------------------------------------------
# Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# ----------------------------------------------------------------------------------------------------------------------
  count = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_count}"   
  # for_each = toset(["", ""])   
  #   # Enter server index name as quoted comma delimited values for state file
  #   # Example: ["SAOne", "SATwo", "SAThree"] put 3 servers in statefile file indexed to SAOne, SATwo and SAThree
# ----------------------------------------------------------------------------------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu               = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_cpu}"         
  memory            = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_memory}" 
  requestedfor      = "${var.tf1211}${var.TFVAR_odi_requestedfor}"
  sharedaccessgroup = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"

  # Edited by builder: ALL DB Specific Items
  # image                = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_image}"  Uses sqlserverdbversion to determine WIN OS version 
  lobname                = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_lobname}"
  sqlserverdbversion     = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_sqlserverdbversion}"
  dbcollation            = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_dbcollation}"
  sqlserverdatabasename  = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_sqlserverdatabasename}"
  databasesize           = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_databasesize}"
  sqlserverdatabaseowner = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_sqlserverdatabaseowner}"
  dbaccessgroup          = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_dbaccessgroup}"
  phi                    = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_phi}"
  pii                    = "${var.tf1211}${var.TFVAR_windows_db_mssql_sa_pii}"

  # Common values across all RSOS
  askid             = "${var.tf1211}${var.TFVAR_odi_askid}"
  targetenv         = "${var.tf1211}${var.TFVAR_odi_targetenv}"
  datacenter        = "${var.tf1211}${var.TFVAR_odi_datacenter}"
  availabilityzone  = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
  networkzone       = "${var.tf1211}${var.TFVAR_odi_networkzone}"
  interfacezone     = "${var.tf1211}${var.TFVAR_odi_interfacezone}"
  vraenv            = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"
}
  
output "windows_odi_db_mssql_sa_server_info" {
  value = {
    for instance in optumvm_dbservermssql_odi.windows_odi_db_mssql_sa:
    instance.servername => instance.*
  }
}