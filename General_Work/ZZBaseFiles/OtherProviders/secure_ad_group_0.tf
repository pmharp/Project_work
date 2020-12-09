resource "optumsecure_group" "secure_ad_group_0" {
  requestedfor  = ""
  group_name = ""                
  group_description = ""
  owner_msid = ""                   # Defaults to the “requestedfor” field value if none is provided
  resource_list = []                # Comma separated list of domains, defaults to MS if left blank. Format [] or [“Domain_1”, “Domain_2”]
  primary_approvers_msid = []       # IDs listed here CANNOT be listed in “backup_approver_msids” field. Format [] or ["UID_1", “UID_2”]
  backup_approver_msids = []        # IDs listed here CANNOT be listed in “primary_approver_msids” field. Format [] or ["UID_1", “UID_2”]
  business_justification = ""
}

output  "secure_ad_group_0_requestid"{
  value = "${optumsecure_group.secure_ad_group_0.request_id}"
}
