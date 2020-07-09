
resource "optumsecure_user" "secure_ad_user_0" {
  requestedfor  = ""
  user_id = ""
  group_name = ""
  resource = ""
  business_justification = ""
}

output  "secure_ad_user_0_requestid"{
  value = "${optumsecure_user.secure_ad_user_0.request_id}"
}