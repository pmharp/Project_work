resource "optumstorage_nas" "storage_nas_0" {
  request_title             = ""   
  owner_msid                = ""   
  ask_app_name              = ""   
  admin_group               = ""   
  backup_required           = ""   
  storage                   = ""   
  data_center               = ""   
  environment_zone          = ""   
  protocol                  = ""   
  network_zone              = ""   
  interface_zone            = ""   
  share_name                = ""   
  client_mount_point        = ""   
  servers                   = []   
  groups_modify             = []   
  groups_read_only          = []   
  service_accounts_modify   = []   
  service_accounts_readonly = []   
  users_to_notify           = []   
  nas_for_infra_or_app      = "true"

  # populate values when making updates to existing NAS provisioned with this provider
  requestor_msid          = "" 
  nas_device_name         = "" 
  sharename_or_exportpath = "" 

}

output "storage_nas_0_id" {
  value = "${optumstorage_nas.storage_nas_0.id}"
}