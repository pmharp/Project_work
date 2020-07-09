# Variables used for the container creation ONLY
variable "TFVAR_DATACENTER_URL"  { default = "OSFI_DATACENTER_URL" }
variable "TFVAR_NAMESPACE"  { default ="OSFI_NAMESPACE" }
variable "TFVAR_CONTAINER"  { default ="OSFI_CONTAINER_NAME" }
variable "TFVAR_IMAGE_URL"  { default ="IMAGE_REPO_URL/IMAGE_REPO_NAMESPACE/IMAGE_NAME:IMAGE_TAG" }
variable "TFVAR_CONTAINER_EXPOSED_PORT"  { default = "IMAGE_EXP_PORT" }
variable "TFVAR_OSFI_SVCACCT_TOKEN"  { default = "SVCACCT_TOKEN_TF" }
variable "TFVAR_OSFI_CERTIFICATE"  { default = "certs/OSFI_CERTIFICATE_TF" }
variable TFVAR_REPLICA_COUNT { default = "OSFI_REPLICA_COUNT" }
