provider "optumvm" {
  # infra-apis to use optumvm_v3.0.1 provider and higher
  host     = "https://infra-apis.optum.com"
  username = "${var.tf1211}${var.PriMsId}"
  password = "${var.tf1211}${var.PriMsIdPwd}"
  insecure = true
  version = "~> 3.0"
}

# terraform { 
#   # S3 details for shared state file
#   backend "s3" { 
#       region                      = "us-standard"                       # Do not edit
#       endpoint                    = "S3_ENDPOINT"                       # Core = s3api-core.uhc.com  DMZ = s3api-dmz.uhc.com
#       bucket                      = "S3_BUCKET"                         # Bucket you have created
#       key                         = "S3_KEY_PATH/terraform.tfstate"     # S3 full path for tfstate file, keep terraform.tfstate for file name
#       access_key                  = "S3_ACCESS_KEY"                     # S3 Access Key ID
#       secret_key                  = "S3_SECRET_KEY"                     # S3 Secret Access Key
#       skip_region_validation      = true                                # Do not edit
#       skip_credentials_validation = true                                # Do not edit
#     } 
# }