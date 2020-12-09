provider "kubernetes" {
  alias = "DataCenter_0"
  load_config_file = "false"
  host = "${var.TFVAR_DATACENTER_URL}"
  cluster_ca_certificate = "${file("${var.TFVAR_OSFI_CERTIFICATE}")}"
  token = "${var.TFVAR_OSFI_SVCACCT_TOKEN}"
}


# Use this code block to manage the tfstate file to a optum s3 backend location
# S3_UCASE text is replaced by PS scripts, DO NOT MOD  
terraform { 
  backend "s3" { 
      region = "us-standard"
      endpoint = "S3_ENDPOINT" 
      bucket = "S3_BUCKET"   
      key = "S3_KEY_PATH"
      access_key = "S3_ACCESS_KEY" 
      secret_key = "S3_SECRET_KEY" 
      skip_region_validation = true 
      skip_credentials_validation = true 
    } 
}

output "OSFI_Exposed_Container_Port" {
  value = "${kubernetes_service.service_1.spec.0.port.0.node_port}"
}