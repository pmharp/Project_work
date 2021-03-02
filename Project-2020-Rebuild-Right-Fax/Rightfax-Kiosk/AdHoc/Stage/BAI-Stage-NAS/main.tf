# OptumNetwork Provider
provider "optumnetwork" {
  ltm_host = "https://navapi-lb-f5.optum.com/" 
  gtm_host = "https://navapi-lb-f5.optum.com/" 
  dns_host = "https://navapi-dns.optum.com/" 
  username = "${var.tf1211}${var.PriMsId}"
  password = "${var.tf1211}${var.PriMsIdPwd}" 
  version = "~> 2.0"
} 

# OptumSecure Provider
provider "optumsecure" { 
  secure_host = "" 
  username = "${var.tf1211}${var.PriMsId}"
  password = "${var.tf1211}${var.PriMsIdPwd}"
  version = "~> 1.0"
} 

# OptumStorage Provider
provider "optumstorage" {
  nas_url = ""                                # For non-prod testing = 'https://storageapps-nas-api-test.optum.com'
  username = "${var.tf1211}${var.PriMsId}"
  password = "${var.tf1211}${var.PriMsIdPwd}"
  version = "~> 1.0"
}
