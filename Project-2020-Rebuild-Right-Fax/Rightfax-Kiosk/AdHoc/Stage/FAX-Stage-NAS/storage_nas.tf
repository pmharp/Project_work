
# # MUST WAIT 24 HOURS after servers are built to create/mod NAS storage

# # ----------------------------------------------------------------------------------------
# # Highlight and uncomment remaining code to enable nas to be built quick keys are [ctrl]+?
# # ----------------------------------------------------------------------------------------

 resource "optumstorage_nas" "storage_nas" {
   count                     = "1"    # Must stay at 1, this creates a request not true build
   request_title             = "Right Fax NAS Non-Prod" # title of the request
   owner_msid                = "kprice26" # MSID of the owner
   ask_app_name              = "BAI" # name of the ask application, required nas_for_infra_or_app = true 
   admin_group               = "rightfax_ark" # name of the admin group, 40 members or less, owner_msid must be member
   storage                   = "2048"     # size in GB. 1-5120 with backup, 1-15360GB w/o backup
   backup_required           = "true"    # Options are 'true', 'false'
   data_center               = "CTC"     # Options are 'CTC', 'ELR'
   environment_zone          = "STAGE"   # Options are 'DEV', 'TEST', 'STAGE', 'PROD'
   protocol                  = "CIFS"     # Options are 'BOTH', 'NFS', 'CIFS'
   network_zone              = "Intranet" # Options are 'Intranet', 'Internet'
   interface_zone            = ""         # Options are 'APP', 'DB', 'PRES', 'NoZone', use "" if network_zone =  Intranet
   share_name                = "BAI_Image_Stage" # share name 
   client_mount_point        = ""     # Linux Mount point beginning "/"" between 2 and 64 characters, alphanumeric and "_"
   servers                   = []     # FQDN Linux Server(s) list which will mount the share, hostname must be in lowercase, ["value1"] or ["value1","value2"]
   groups_modify             = [rightfax_ark]     # global group(s) list which can modify share content, if filled in use ["value1","value2"]
   groups_read_only          = [rightfax]     # global group(s) list which can read share content, if filled in use ["value1","value2"]
   service_accounts_modify   = []     # service account(s) list which can modify share content, if filled in use ["value1","value2"]
   service_accounts_readonly = []     # service account(s) list which can read share content, if filled in use ["value1","value2"]
   users_to_notify           = []     # user mail address(es) to be notified of NAS creation, if filled in use ["value1","value2"]
   nas_for_infra_or_app      = "true" # Options are 'true', 'false' When provisioning for app use true
   owner_gl_code             = ""     # Uses owner_misd's glcode when nas_for_infra_or_app = false or ask_app_name = ""

#   # populate values when making updates to existing NAS provisioned with this provider
#   requestor_msid          = "" # msid of the requestor
#   nas_device_name         = "" # NAS device name - to be retrieved from the Email
#   sharename_or_exportpath = "" # NAS export path/sharename
# }

 output "storage_nas_info" {
   value = {
     for instance in optumstorage_nas.storage_nas:
     instance.id => instance.*
   }
 }
