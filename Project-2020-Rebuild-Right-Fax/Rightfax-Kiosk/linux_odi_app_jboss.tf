# resource "optumvm_jboss_odi" "linux_odi_app_jboss" {

# # ----------------------------------------------------------------------------------------------------------------------
# # Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# # Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# # ----------------------------------------------------------------------------------------------------------------------
#   count = "${var.tf1211}${var.TFVAR_linux_jboss_count}"   
#   # for_each = toset(["", ""])   
#   #   # Enter server index name as quoted comma delimited values for state file
#   #   # Example: ["JBoss1", "JBoss2", "myApp1"] put 3 servers in statefile file indexed to JBoss1 JBoss2 and myApp1
# # ----------------------------------------------------------------------------------------------------------------------

# #   # Edited by builder: Can mod for Day 2 Actions
#   cpu               = "${var.tf1211}${var.TFVAR_linux_jboss_cpu}"       # Options are 1 - 16 using only EVEN numbers
#   memory            = "${var.tf1211}${var.TFVAR_linux_jboss_memory}"    # Options are 4 - 128 using only EVEN numbers
#   requestedfor      = "${var.tf1211}${var.TFVAR_odi_requestedfor}"      # modded to NOT have @ms.ds.uhc.com
#   sharedaccessgroup = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}" # Required for initial build now
# #   chefrunlist       = ""  # DNU on initial build, fill in after server is built. Comma delimited list of Case Sensitive cookbooks on chef server to run

#   # Maintenance Window name value pairs
#   maintenancegroup        = "0" # Optional with options of DEV=0 or 1, TEST=0 or 1, STAGE=0 or 2, PROD=0 or 3
#   maintenancerebootwindow = ""  # Options "" for none, Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
#   maintenancereboottime   = ""  # Options "" for none, 00:00:00-23:50:00 in 10 minute increments (start time of 4 hour block)

# #   # Edited by builder: CANNOT MOD for day 2
#   image                = "${var.tf1211}${var.TFVAR_linux_jboss_image}"         # options are 'v8-rhel-8', 'v8-rhel-7'
#   lobname              = "${var.tf1211}${var.TFVAR_linux_jboss_lobname}"       # options 'LOB Internal DO_NOT_USE'
#   jbossversion         = "${var.tf1211}${var.TFVAR_linux_jboss_version}"       # options are '7.2.9'
#   privunixid           = "${var.tf1211}${var.TFVAR_odi_privunixid}"            # Secondary UNIX ID: Able to login and has Admin Rights
#   privuserunixgroup    = "${var.tf1211}${var.TFVAR_odi_privuserunixgroup}"     # Unix Group able to login and has Admin Rights
#   nonprivunixid        = "${var.tf1211}${var.TFVAR_odi_nonprivunixid}"         # Secondary UNIX ID: Able to login only - NO ADMIN rights
#   nonprivuserunixgroup = "${var.tf1211}${var.TFVAR_odi_nonprivuserunixgroup}"  # Unix Group able to login only - NO ADMIN rights

# #    # Common values across all RSOS
#   apptag              = "${var.tf1211}${var.TFVAR_odi_apptag}"
#   askid               = "${var.tf1211}${var.TFVAR_odi_askid}"
#   ppmoprojectnum      = "${var.tf1211}${var.TFVAR_odi_ppmoprojectnum}"
#   ppmoapplicationname = "${var.tf1211}${var.TFVAR_odi_ppmoapplicationname}"
#   targetenv           = "${var.tf1211}${var.TFVAR_odi_targetenv}"
#   datacenter          = "${var.tf1211}${var.TFVAR_odi_datacenter}"
#   availabilityzone    = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
#   networkzone         = "${var.tf1211}${var.TFVAR_odi_networkzone}"
#   interfacezone       = "${var.tf1211}${var.TFVAR_odi_interfacezone}"
#   drcode              = "${var.tf1211}${var.TFVAR_odi_drcode}"
#   reason              = "${var.tf1211}${var.TFVAR_linux_jboss_reason}"
#   vraenv              = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"
# }

# output "linux_odi_app_jboss_server_info" {
#   value = {
#     for instance in optumvm_jboss_odi.linux_odi_app_jboss:
#     instance.servername => instance.*
#   }
# }