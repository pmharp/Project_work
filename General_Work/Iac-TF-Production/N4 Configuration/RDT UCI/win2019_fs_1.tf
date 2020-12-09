
# Defaults to Full Service if want to use Self Service
# Change "optumvm_win2019fsvm" to "optumvm_win2019ssvm" in row 4
# Do FIND on "win2019_fs_" and REPLACE with "win2019_ss_" b 11 occurances)
resource "optumvm_win2019fsvm" "win2019_fs_1" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumvm/vm_Windows.html#windows-support-matrix
  # Edited by builder: Can mod for Day 2 Actions
  cpu                  = "${var.tf1211}${var.TFVAR_cpu}"
  memory               = "${var.tf1211}${var.TFVAR_memory}"
  disks                = "${var.tf1211}${var.TFVAR_disks}"
  requestedfor         = "${var.tf1211}${var.TFVAR_requestedfor}@ms.ds.uhc.com"
  vrasharedaccessgroup = "${var.tf1211}${var.TFVAR_vrasharedaccessgroup}"

  # Edited by builder: CANNOT MOD for day 2
  servertype            =  "${var.tf1211}${var.TFVAR_servertype}"
  vradescription        = "${var.tf1211}${var.TFVAR_vradescription}"

  # Common values across all RSOS
  askid                = "${var.tf1211}${var.TFVAR_askid}"
  ppmoprojnum          = "${var.tf1211}${var.TFVAR_ppmoprojnum}"
  targetenv            = "${var.tf1211}${var.TFVAR_targetenv}"
  datacenter           = "${var.tf1211}${var.TFVAR_datacenter}"
  resiliencyzone       = "${var.tf1211}${var.TFVAR_resiliencyzone}"
  networkzone          = "${var.tf1211}${var.TFVAR_networkzone}"
  interfacezone        = "${var.tf1211}${var.TFVAR_interfacezone}"
  drcode               = "${var.tf1211}${var.TFVAR_drcode}"
  vrareasons           = "${var.tf1211}${var.TFVAR_vrareasons}"
  sedsupport           = "${var.tf1211}${var.TFVAR_sedsupport}"
  vraenv               = "${var.tf1211}${var.TFVAR_vraenv}"
  useserviceaccount    = "${var.tf1211}${var.TFVAR_useserviceaccount}" 

  # Maintenance Windows name value pairs
  maintenancegroup      = "${var.tf1211}${var.TFVAR_maintenancegroup}"
  maintenancerebootday  = "${var.tf1211}${var.TFVAR_maintenancerebootday}"
  maintenancereboothour = "${var.tf1211}${var.TFVAR_maintenancereboothour}" 
   
  # DO NOT EDIT: Pulled from TFVars file and ps file as input
  # RSO Specific Entries
  msid                 = "${var.tf1211}${var.TFVAR_2ndadid}"
  groupname            = "${var.tf1211}${var.TFVAR_adprivilegedgg}"
  iaasagree            = "${var.tf1211}${var.TFVAR_iaasagree}"
}

output "win2019_fs_1_servername" {
  value = "${optumvm_win2019fsvm.win2019_fs_1.servername}"
}

output "win2019_fs_1_ipaddress" {
  value = "${optumvm_win2019fsvm.win2019_fs_1.ipaddress}"
}
output "win2019_fs_1_cpu" {
  value = "${optumvm_win2019fsvm.win2019_fs_1.cpu}"
}

output "win2019_fs_1_memory" {
  value = "${optumvm_win2019fsvm.win2019_fs_1.memory}"
}

output "win2019_fs_1_targetenv" {
  value = "${optumvm_win2019fsvm.win2019_fs_1.targetenv}"
}