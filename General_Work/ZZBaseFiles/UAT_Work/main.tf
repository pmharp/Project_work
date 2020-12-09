provider "optumvm" {
  ##-------------------  Auto Determined ------------------- ##
  # infra-apis to use optumvm_v3.0.1 provider and higher     #
  # host     = "https://infra-apis.optum.com"                # 
  ##                                                         #
  # infra-apis to use optumvm v2.0.0 provider and LOWER      #
  # host     = "https://paasapi.optum.com"                   #
  ##-------------------  Auto Determined ------------------- ##
  username = "${var.tf1211}${var.PriMsId}"
  password = "${var.tf1211}${var.PriMsIdPwd}"
  insecure = true
  version = "~> 3.0"
}

provider "optumnetwork" { 
  dns_host = "https://navapi-dns.optum.com/" 
  username = "${var.tf1211}${var.PriMsId}"
  password = "${var.tf1211}${var.PriMsIdPwd}" 
  version = "~> 2.0"
} 

# # Uncomment out this block if wish to use OptumSecure Provider
# provider "optumsecure" { 
#   secure_host = "" 
#   username = "${var.tf1211}${var.PriMsId}"
#   password = "${var.tf1211}${var.PriMsIdPwd}"
#   version = "~> 1.0"
# } 

# # Uncomment out this block if wish to use OptumStorage Provider
# provider "optumstorage" { 
#   nas_url = ""                                  # Options:  Production=PRD",  Stage Testing="STG"
#   username = "${var.tf1211}${var.PriMsId}"
#   password = "${var.tf1211}${var.PriMsIdPwd}" 
#   version = "~> 1.0"
# }

# # Deprecated: Functionality added to the above OptumStorage Provider
# provider "optumnas" { 
#   nas_url  = "PRD"                 # Options:  Production=PRD",  Stage Testing="STG"
#   username = "${var.tf1211}${var.PriMsId}"
#   password = "${var.tf1211}${var.PriMsIdPwd}" 
#   version = "~> 1.0"
# } 

# terraform { 
#   # S3_UCASE text is replaced by PS scripts, DO NOT MOD  
#   backend "s3" { 
#       region                      = "us-standard"
#       endpoint                    = "S3_ENDPOINT" 
#       bucket                      = "S3_BUCKET"   
#       key                         = "S3_KEY_PATH"
#       access_key                  = "S3_ACCESS_KEY" 
#       secret_key                  = "S3_SECRET_KEY" 
#       skip_region_validation      = true 
#       skip_credentials_validation = true 
#     } 
# }