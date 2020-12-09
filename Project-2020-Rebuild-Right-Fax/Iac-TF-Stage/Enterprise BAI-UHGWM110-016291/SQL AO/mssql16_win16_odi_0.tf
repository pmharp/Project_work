resource "optumvm_dbservermssql_odi" "mssql16_win16_odi_0" {
  # Edited by builder: Can mod for Day 2 Actions
  cpu                   = "8"    # Options are 2-16, even values only
  memory                = "64"    # Range is 8-128 GB, even values only
  requestedfor          = "${var.tf1211}${var.TFVAR_odi_requestedfor}"
  sharedaccessgroup     = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"

  # Edited by builder: ALL DB Specific Items
  lobname                  = "UHC Core Services"      
  sqlserverdbversion       = ""                      # Only option is ""     
  dbcollation              = "SQL_Latin1_General_CP1_CI_AS" # Latin1_General_CI_AS, SQL_Latin1_General_CP1_CI_AS, Latin1_General_BIN, Latin1_General_CI_AS_KS_WS
                                                     # SQL_Latin1_General_CP1_CI_AI, Latin1_General_CI_AI, SQL_Latin1_General_CP1_CS_AS, Latin1_General_BIN2
  sqlserverdatabasename    = "RFSQLSTAGEA"                      # Lowercase Alphanumeric values with length 1-64
  databasesize             = "50"                      # Range is 1-3072 GB
  sqlserverdatabaseowner   = "kprice27"
  dbaccessgroup            = "RightFax_ARK"
  phi                      = "No"                                         
  pii                      = "No"                                         

  # Common values across all RSOS
  askid             = "${var.tf1211}${var.TFVAR_odi_askid}"
  targetenv         = "${var.tf1211}${var.TFVAR_odi_targetenv}"
  datacenter        = "${var.tf1211}${var.TFVAR_odi_datacenter}"       
  availabilityzone  = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
  networkzone       = "${var.tf1211}${var.TFVAR_odi_networkzone}"    
  interfacezone     = "${var.tf1211}${var.TFVAR_odi_interfacezone}"  
  vraenv            = "${var.tf1211}${var.TFVAR_odi_vraenv}"

  # DO NOT EDIT: Pulled from TFVars file and ps file as input
  # RSO Specific Entries
  image = "v8-w2019"
}
  
output "mssql16_win16_odi_0_servername" {
  value = "${optumvm_dbservermssql_odi.mssql16_win16_odi_0.servername}"
}
output "mssql16_win16_odi_0_ipaddress" {
  value = "${optumvm_dbservermssql_odi.mssql16_win16_odi_0.ipaddress}"
}
output "mssql16_win16_odi_0_cpu" {
  value = "${optumvm_dbservermssql_odi.mssql16_win16_odi_0.cpu}"
}
output "mssql16_win16_odi_0_memory" {
  value = "${optumvm_dbservermssql_odi.mssql16_win16_odi_0.memory}"
}
output "mssql16_win16_odi_0_targetenv" {
  value = "${optumvm_dbservermssql_odi.mssql16_win16_odi_0.targetenv}"
}