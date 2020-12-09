resource "optumvm_jbossvm" "jboss_0" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumvm/vm_jboss.html#jboss-matrix
  # Edited by builder: Can mod for Day 2 Actions
  cpu                  = "1"
  memory               = "4"
  requestedfor         = "${var.tf1211}${var.TFVAR_requestedfor}@ms.ds.uhc.com"
  vrasharedaccessgroup = "${var.tf1211}${var.TFVAR_vrasharedaccessgroup}"

  # Edited by builder: Once Built Cannot change
  lobname                   = ""
  mui                       = ""
  vradescription            = "${var.tf1211}${var.TFVAR_vradescription}"
  jbossversion              = "7.0"
  apsdescription            = "jboss v7.0"
  jbossexceptionfactor      = "Business"
  jbossexceptionexplanation = "NEED_TO_CHANGE"

  # Common values across all RSOS
  askid                = "${var.tf1211}${var.TFVAR_askid}"
  ppmoprojnum          = "${var.tf1211}${var.TFVAR_ppmoprojnum}"
  targetenv            = "${var.tf1211}${var.TFVAR_targetenv}"
  datacenter           = "${var.tf1211}${var.TFVAR_datacenter}"
  resiliencyzone       = "${var.tf1211}${var.TFVAR_resiliencyzone}"
  networkzone          = "${var.tf1211}${var.TFVAR_networkzone}"
  interfacezone        = "${var.tf1211}${var.TFVAR_interfacezone}"
  drcode               = "${var.tf1211}${var.TFVAR_drcode}"
  drrto                = "${var.tf1211}${var.TFVAR_drrto}"
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
  unixid               = "${var.tf1211}${var.TFVAR_2ndunixid}"
  paasagree            = "${var.tf1211}${var.TFVAR_paasagree}"
}

output "jboss_0_servername" {
  value = "${optumvm_jbossvm.jboss_0.servername}"
}

output "jboss_0_ipaddress" {
  value = "${optumvm_jbossvm.jboss_0.ipaddress}"
}

output "jboss_0_cpu" {
  value = "${optumvm_jbossvm.jboss_0.cpu}"
}

output "jboss_0_memory" {
  value = "${optumvm_jbossvm.jboss_0.memory}"
}

output "jboss_0_targetenv" {
  value = "${optumvm_jbossvm.jboss_0.targetenv}"
}
output "jboss_0_jbossversion" {
  value = "${optumvm_jbossvm.jboss_0.jbossversion}"
}