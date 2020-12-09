
resource "optumvm_windowsvm" "windows_odi_0" {

  # OS Building -----------------------------------
  image = ""  # options are 'v8-w2019', 'v8-w2016'
  # -----------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu                = "1"        # Options are 1- 16
  memory             = "4"        # Options are 4 - 128 using EVEN and ODD numbers
  # Disk 1 will always get created see disk section below
  requestedfor       = "${var.tf1211}${var.TFVAR_odi_requestedfor}"             # modded to NOT have @ms.ds.uhc.com
  sharedaccessgroup  = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"        # Required for initial build now

  # Maintenance Windows name value pairs
  maintenancegroup         = "0"  # Required with options of DEV=0 or 1, TEST=0 or 1, STAGE=0 or 2, PROD=0 or 3
  maintenancerebootwindow  = ""   # Options "" for none, Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
  maintenancereboottime    = ""   # Options "" for none, 00:00:00-23:50:00 in 10 minute increments (start time of 4 hour block)

  # Edited by builder: CANNOT MOD for day 2
  secondarywinid        = "${var.tf1211}${var.TFVAR_odi_privadid}"          # Secondary (domain specific) ID to Admin Windows devices (Ids are from MS or DMZMGMT)
  privuserwingroup      = "${var.tf1211}${var.TFVAR_odi_privuseradgroup}"   # Privileged AD Group that 2ndadid is part of to admin of windows devices

   # Common values across all RSOS
  apptag              = "${var.tf1211}${var.TFVAR_odi_apptag}"
  askid               = "${var.tf1211}${var.TFVAR_odi_askid}"
  ppmoprojectnum      = "${var.tf1211}${var.TFVAR_odi_ppmoprojectnum}"
  ppmoapplicationname = "${var.tf1211}${var.TFVAR_odi_ppmoapplicationname}"
  targetenv           = "${var.tf1211}${var.TFVAR_odi_targetenv}"
  datacenter          = "${var.tf1211}${var.TFVAR_odi_datacenter}"
  availabilityzone    = "${var.tf1211}${var.TFVAR_odi_availabilityzone}"
  networkzone         = "${var.tf1211}${var.TFVAR_odi_networkzone}"
  interfacezone       = "${var.tf1211}${var.TFVAR_odi_interfacezone}"
  drcode              = "${var.tf1211}${var.TFVAR_odi_drcode}"
  reason              = "${var.tf1211}${var.TFVAR_odi_reason}"
  vraenv              = "${var.tf1211}${var.TFVAR_odi_vraenv}"

  # Uncomnment the disk blocks you need to provision in order and update and Do not skip disk blocks when uncommenting
  # -----------
  # Disk 1 will ALWAYS be created even if commented out
  disk1sizegb     = "10"  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  disk1driveltr   = "E"    # Drive letters E ... Z
  # -----------
  # disk2sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk2driveltr = ""  # Drive letters F ... Z
  # -----------
  # disk3sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk3driveltr = ""  # Drive letters F ... Z
  # -----------
  # disk4sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk4driveltr = ""  # Drive letters F ... Z
  # -----------  
  # disk5sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk5driveltr = ""  # Drive letters F ... Z
  # -----------
  # disk6sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk6driveltr = ""  # Drive letters F ... Z
  # -----------
  # disk7sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk7driveltr = ""  # Drive letters F ... Z
  # -----------
  # disk8sizegb   = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk8driveltr = ""  # Drive letters F ... Z
}

output "windows_odi_0_servername" {
  value = "${optumvm_windowsvm.windows_odi_0.servername}"
}

output "windows_odi_0_ipaddress" {
  value = "${optumvm_windowsvm.windows_odi_0.ipaddress}"
}

output "windows_odi_0_image_used" {
  value = "${optumvm_windowsvm.windows_odi_0.image}"
}

output "windows_odi_0_cpu" {
  value = "${optumvm_windowsvm.windows_odi_0.cpu}"
}

output "windows_odi_0_memory" {
  value = "${optumvm_windowsvm.windows_odi_0.memory}"
}

output "windows_odi_0_targetenv" {
  value = "${optumvm_windowsvm.windows_odi_0.targetenv}"
}

output "windows_odi_0_datacenter" {
  value = "${optumvm_windowsvm.windows_odi_0.datacenter}"
}

output "windows_odi_0_networkzone" {
  value = "${optumvm_windowsvm.windows_odi_0.networkzone}"
}