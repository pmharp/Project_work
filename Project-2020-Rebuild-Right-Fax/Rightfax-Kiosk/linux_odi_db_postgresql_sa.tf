# resource "optumvm_dbserver_postgesql_odi" "linux_odi_db_postgresql_sa" {

# # ----------------------------------------------------------------------------------------------------------------------
# # Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# # Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# # ----------------------------------------------------------------------------------------------------------------------
#   count = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_count}"   
#   # for_each = toset(["", ""])   
#   #   # Enter server index name as quoted comma delimited values for state file
#   #   # Example: ["SAOne", "SATwo", "SAThree"] put 3 servers in statefile file indexed to SAOne, SATwo and SAThree
# # ----------------------------------------------------------------------------------------------------------------------

#   # Edited by builder: Can mod for Day 2 Actions
#   cpu               = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_cpu}"         
#   memory            = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_memory}"      
#   requestedfor      = "${var.tf1211}${var.TFVAR_odi_requestedfor}"
#   sharedaccessgroup = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"
  
#  # Edited by builder: ALL DB Specific Items
#   image                  = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_image}"
#   lobname                = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_lobname}"
#   postgresqldbversion    = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_postgresqldbversion}"
#   postgresqldatabasename = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_postgresqldatabasename}"
#   postgresqldatabasesize = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_postgresqldatabasesize}"
#   phi                    = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_phi}"
#   pii                    = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_pii}"
#   privunixid             = "${var.tf1211}${var.TFVAR_odi_privunixid}"            
#   privuserunixgroup      = "${var.tf1211}${var.TFVAR_odi_privuserunixgroup}"     

#   # Common values across all RSOS
#   askid            = "${var.tf1211}${var.TFVAR_odi_askid}"
#   targetenv        = "${var.tf1211}${var.TFVAR_odi_targetenv}"
#   datacenter       = "${var.tf1211}${var.TFVAR_odi_datacenter}"
#   availabilityzone = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
#   networkzone      = "${var.tf1211}${var.TFVAR_odi_networkzone}"
#   interfacezone    = "${var.tf1211}${var.TFVAR_odi_interfacezone}"
#   reason           = "${var.tf1211}${var.TFVAR_linux_db_postgresql_sa_reason}"
#   vraenv           = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"
# }
  
# output "linux_odi_db_postgresql_sa_server_info" {
#   value = {
#     for instance in optumvm_dbservermysql_odi.linux_odi_db_postgresql_sa:
#     instance.servername => instance.*
#   }
# }