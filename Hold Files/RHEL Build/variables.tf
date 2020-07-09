
# ------------------------------------------------------------------------------------------
# VRA 7 LEGACY SECTION
# ------------------------------------------------------------------------------------------
#Commonly needed Values across all files
variable "TFVAR_requestedfor"  { default ="" }
variable "TFVAR_askid"  { default ="" }
variable "TFVAR_targetenv"  { default ="" }
variable "TFVAR_datacenter"  { default ="" }
variable "TFVAR_resiliencyzone"  { default ="" }
variable "TFVAR_networkzone"  { default ="" }
variable "TFVAR_interfacezone"  { default ="" }
variable "TFVAR_drcode"  { default ="" }
variable "TFVAR_drrto"  { default ="" }
variable "TFVAR_vradescription"  { default ="" }
variable "TFVAR_vrasharedaccessgroup"  { default ="" }
variable "TFVAR_ppmoprojnum"  { default ="" }
variable "TFVAR_maintenancegroup"  { default ="" }
variable "TFVAR_maintenancerebootday"  { default ="" }
variable "TFVAR_maintenancereboothour"  { default ="" }

#RSO Specific Common Values
variable "TFVAR_2ndunixid"  { default ="" }
variable "TFVAR_2ndadid"  { default ="" }
variable "TFVAR_adprivilegedgg"  { default ="" }

# Not asked for in PS files these are needed, but should not be changed
variable "TFVAR_vrareasons"  { default ="" }
variable "TFVAR_sedsupport"  { default ="Yes" }
variable "TFVAR_vraenv"  { default ="test" }
variable "TFVAR_useserviceaccount"  { default ="yes" }

# Agreements for IAAS and PAAS
variable "TFVAR_paasagree"  { default ="yes" }
variable "TFVAR_iaasagree"  { default ="yes" }
# ------------------------------------------------------------------------------------------



# ------------------------------------------------------------------------------------------
# ODI SECTION
# ------------------------------------------------------------------------------------------
variable "TFVAR_odi_apptag"  { default ="None" }
variable "TFVAR_odi_askid"  { default ="" }
variable "TFVAR_odi_ppmoprojectnum"  { default ="" }
variable "TFVAR_odi_ppmoapplicationname"  { default ="" }
variable "TFVAR_odi_requestedfor"  { default ="" }
variable "TFVAR_odi_sharedaccessgroup"  { default ="" }
variable "TFVAR_odi_targetenv"  { default ="" }
variable "TFVAR_odi_datacenter"  { default ="" }
variable "TFVAR_odi_availabilityzone"  { default ="" }
variable "TFVAR_odi_networkzone"  { default ="" }
variable "TFVAR_odi_interfacezone"  { default ="" }
variable "TFVAR_odi_drcode"  { default ="" }

# RSO specific common variables - RHEL
variable "TFVAR_odi_privunixid"  { default ="" }
variable "TFVAR_odi_privuserunixgroup"  { default ="dce" }
variable "TFVAR_odi_nonprivunixid"  { default ="" }
variable "TFVAR_odi_nonprivuserunixgroup"  { default ="dce" }

# RSO specific common variables - WINDOWS
variable "TFVAR_odi_privadid"  { default ="" }
variable "TFVAR_odi_privuseradgroup"  { default ="" }

# Not asked for in PS files these are needed, but should not be changed
variable "TFVAR_odi_reason"  { default ="" }
variable "TFVAR_odi_vraenv"  { default ="" }
# ------------------------------------------------------------------------------------------



# ------------------------------------------------------------------------------------------
# MAIN.TF and terraform versioning variables
# ------------------------------------------------------------------------------------------
# Needed for Provisioning - main.tf
variable "PriMsId" {}
variable "PriMsIdPwd" {}

# Needed for making Tf version pre 12.11 work with version after 12.11
variable "tf1211" {default=""}
# ------------------------------------------------------------------------------------------