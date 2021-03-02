
# ------------------------------------------------------------------------------------------
# MAIN.TF and terraform versioning variables
# ------------------------------------------------------------------------------------------
# Needed for Provisioning - main.tf
variable "PriMsId" {}
variable "PriMsIdPwd" {}

# Needed for making Tf version pre 12.11 work with version after 12.11
variable "tf1211" {default=""}
# ------------------------------------------------------------------------------------------

