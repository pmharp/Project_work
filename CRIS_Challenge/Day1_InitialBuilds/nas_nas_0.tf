IACresource "optumnas_resourcenas" "nas_nas_0" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-nas/NAS_NAS.html#nas-capacity-matrix
  request_title             = "IAC_Challenge_2"                                       # title of the request
  owner_msid                = "pharp"                                                 # MSID of the owner
  ask_app_name              = "Advancing Cross Functionality SED Automation Training" # name of the ask application
  admin_group               = "UHTSE_Viewer"                                          # name of the admin group, 40 members or less
  backup_required           = "false"                                                 # true or false
  storage                   = "10"                                                    # size in GB
  data_center               = "ELR"                                                   # CTC or ELR
  environment_zone          = "TEST"                                                  # DEV or TEST or STAGE or PROD
  protocol                  = "BOTH"                                                  # BOTH or NFS or CIFS
  network_zone              = "Intranet"                                              # Intranet or Internet
  interface_zone            = ""                                                      # APP or DB or PRES or NoZone, use "" if network_zone =  Intranet
  share_name                = "IAC_MTN"                                               # share name
  client_mount_point        = "/IAC_REL"                                              # Linux Mount Point
  servers                   = ["WEVRT68398"]                                          # FQDN Linux Server(s) list which will mount the share, hostname must be in uppercase, ["value1"] or ["value1","value2"]
  groups_modify             = ["SED_All_Teams"]                                       # global group(s) list which can modify share content, if filled in use ["value1","value2"]
  groups_read_only          = [""]                                                    # global group(s) list which can read share content, if filled in use ["value1","value2"]
  service_accounts_modify   = [""]                                                    # service account(s) list which can modify share content, if filled in use ["value1","value2"]
  service_accounts_readonly = [""]                                                    # service account(s) list which can read share content, if filled in use ["value1","value2"]
  users_to_notify           = ["patrick_m_harp@optum.com"]                            # user mail address(es) to be notified of NAS creation, if filled in use ["value1","value2"]
  nas_for_infra_or_app      = "true"

  # populate values when making updates to existing NAS provisioned with this provider
  requestor_msid          = "" # msid of the requestor
  nas_device_name         = "" # NAS device name - to be retrieved from the Email
  sharename_or_exportpath = "" # NAS export path/sharename

}

output "nas_nas_0_request_id" {
  value = "${optumnas_resourcenas.nas_nas_0.request_id}"
}
