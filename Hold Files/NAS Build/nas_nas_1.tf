resource "optumnas_resourcenas" "nas_nas_1" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-nas/NAS_NAS.html#nas-capacity-matrix
  request_title             = "IAC Challenge 2" # title of the request
  owner_msid                = "pharp"           # MSID of the owner
  ask_app_name              = "IAC"             # name of the ask application
  admin_group               = ""                # name of the admin group, 40 members or less
  backup_required           = "false"           # true or false
  storage                   = "10"              # size in GB
  data_center               = "ELR"             # CTC or ELR
  environment_zone          = "Test"            # DEV or TEST or STAGE or PROD
  protocol                  = "Both"            # BOTH or NFS or CIFS
  network_zone              = "Intranet"        # Intranet or Internet
  interface_zone            = ""                # APP or DB or PRES or NoZone, use "" if network_zone =  Intranet
  share_name                = "IAC_2"           # share name
  client_mount_point        = ""                # Linux Mount Point
  servers                   = []                # FQDN Linux Server(s) list which will mount the share, hostname must be in uppercase, ["value1"] or ["value1","value2"]
  groups_modify             = []                # global group(s) list which can modify share content, if filled in use ["value1","value2"]
  groups_read_only          = []                # global group(s) list which can read share content, if filled in use ["value1","value2"]
  service_accounts_modify   = []                # service account(s) list which can modify share content, if filled in use ["value1","value2"]
  service_accounts_readonly = []                # service account(s) list which can read share content, if filled in use ["value1","value2"]
  users_to_notify           = []                # user mail address(es) to be notified of NAS creation, if filled in use ["value1","value2"]
  nas_for_infra_or_app      = "true"

  # populate values when making updates to existing NAS provisioned with this provider
  requestor_msid          = "" # msid of the requestor
  nas_device_name         = "" # NAS device name - to be retrieved from the Email
  sharename_or_exportpath = "" # NAS export path/sharename

}

output "nas_nas_1_request_id" {
  value = "${optumnas_resourcenas.nas_nas_1.request_id}"
}
