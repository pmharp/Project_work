resource "optumvm_windowsvm" "windows_odi_app" {

# ----------------------------------------------------------------------------------------------------------------------
# Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# ----------------------------------------------------------------------------------------------------------------------
  count = "${var.tf1211}${var.TFVAR_windows_app_count}"   
  # for_each = toset(["", ""])   
  #   # Enter server index name as quoted comma delimited values for state file
  #   # Example: ["Apache1", "Apache2", "myApp1"] put 3 servers in statefile file indexed to Apache1 Apache2 and myApp1
# ----------------------------------------------------------------------------------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu                = "${var.tf1211}${var.TFVAR_windows_app_cpu}"       # Options are 1 - 16 using only EVEN numbers
  memory             = "${var.tf1211}${var.TFVAR_windows_app_memory}"    # Options are 4 - 128 using only EVEN numbers
  requestedfor       = "${var.tf1211}${var.TFVAR_odi_requestedfor}"      # modded to NOT have @ms.ds.uhc.com
  sharedaccessgroup  = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}" # Required for initial build now
  chefrunlist        = ""  # DNU on initial build, fill in after server is built. Comma delimited list of Case Sensitive cookbooks on chef server to run

  # Maintenance Windows name value pairs
  maintenancegroup         = "0"  # Required with options of DEV=0 or 1, TEST=0 or 1, STAGE=0 or 2, PROD=0 or 3
  maintenancerebootwindow  = ""   # Options "" for none, Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
  maintenancereboottime    = ""   # Options "" for none, 00:00:00-23:50:00 in 10 minute increments (start time of 4 hour block)

  # Edited by builder: CANNOT MOD for day 2
  image            = "${var.tf1211}${var.TFVAR_windows_app_image}"    # options are 'v8-w2019', 'v8-w2016'
  secondarywinid   = "${var.tf1211}${var.TFVAR_odi_privadid}"         # Secondary (domain specific) ID to Admin Windows devices (Ids are from MS or DMZMGMT)
  privuserwingroup = "${var.tf1211}${var.TFVAR_odi_privuseradgroup}"  # Privileged AD Group that 2ndadid is part of to admin of windows devices

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
  reason              = "${var.tf1211}${var.TFVAR_windows_app_reason}"
  vraenv              = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"

  # Uncomnment the disk blocks you need to provision in order and update and Do not skip disk blocks when uncommenting
  # -----------
  # Disk 1 will ALWAYS be created even if commented out
  disk1sizegb   = "100"  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  disk1driveltr = "E"    # Drive letters E ... Z
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

output "windows_odi_app_server_info" {
  value = {
    for instance in optumvm_windowsvm.windows_odi_app:
    instance.servername => instance.*
  }
}