resource "optumvm_linuxvm" "linux_odi_app" {

# ----------------------------------------------------------------------------------------------------------------------
# Either use count for state file to use [0] based array indexes # or for_each to create your own meaningful indexes
# Default is to use count fed in from tfvars, comment out the line not needed "count = ..." or "for_each = ..."
# ----------------------------------------------------------------------------------------------------------------------
  count = "${var.tf1211}${var.TFVAR_linux_app_count}"   
  # for_each = toset(["", ""])   
  #   # Enter server index name as quoted comma delimited values for state file
  #   # Example: ["Apache1", "Apache2", "myApp1"] put 3 servers in statefile file indexed to Apache1 Apache2 and myApp1
# ----------------------------------------------------------------------------------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu               = "${var.tf1211}${var.TFVAR_linux_app_cpu}"         # Options are 1 - 16 using only EVEN numbers
  memory            = "${var.tf1211}${var.TFVAR_linux_app_memory}"      # Options are 4 - 128 using only EVEN numbers
  requestedfor      = "${var.tf1211}${var.TFVAR_odi_requestedfor}"      # modded to NOT have @ms.ds.uhc.com
  sharedaccessgroup = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}" # Required for initial build now
  chefrunlist       = ""  # DNU on initial build, fill in after server is built. Comma delimited list of Case Sensitive cookbooks on chef server to run

  # Maintenance Window name value pairs
  maintenancegroup        = "0" # Optional with options of DEV=0 or 1, TEST=0 or 1, STAGE=0 or 2, PROD=0 or 3
  maintenancerebootwindow = ""  # Options "" for none, Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
  maintenancereboottime   = ""  # Options "" for none, 00:00:00-23:50:00 in 10 minute increments (start time of 4 hour block)

  # Edited by builder: CANNOT MOD for day 2
  image                = "${var.tf1211}${var.TFVAR_linux_app_image}"           # options are 'v8-rhel-8', 'v8-rhel-7', 'v8-centos-7'
  privunixid           = "${var.tf1211}${var.TFVAR_odi_privunixid}"            # Secondary UNIX ID: Able to login and has Admin Rights
  privuserunixgroup    = "${var.tf1211}${var.TFVAR_odi_privuserunixgroup}"     # Unix Group able to login and has Admin Rights
  nonprivunixid        = "${var.tf1211}${var.TFVAR_odi_nonprivunixid}"         # Secondary UNIX ID: Able to login only - NO ADMIN rights
  nonprivuserunixgroup = "${var.tf1211}${var.TFVAR_odi_nonprivuserunixgroup}"  # Unix Group able to login only - NO ADMIN rights

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
  reason              = "${var.tf1211}${var.TFVAR_linux_app_reason}"
  vraenv              = "${var.tf1211}${upper(var.TFVAR_odi_vraenv)}"

  # Uncomnment the disk blocks you need to provision in order and update and Do not skip disk blocks when uncommenting
  # -----------
  # Disk 1 will ALWAYS be created even if commented out
  disk1sizegb = "10"     # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  disk1mntpt  = "/app"   # Mount point for the disk, starts with /
  disk1owner  = "${var.tf1211}${var.TFVAR_odi_privunixid}"         # Secondary Unix ID that will own the mount
  disk1group  = "${var.tf1211}${var.TFVAR_odi_privuserunixgroup}"  # Unix group that will on the mount                                    
  disk1perms  = "755" # Octal permissions notation to be applied to the mount
  # -----------
  # disk2sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk2mntpt  = ""  # Mount point for the disk, starts with /
  # disk2owner  = ""  # Secondary Unix ID that will own the mount
  # disk2group  = ""  # Unix group that will on the mount 
  # disk2perms  = ""  # Octal permissions notation to be applied to the mount
  # -----------
  # disk3sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk3mntpt  = ""  # Mount point for the disk, starts with /
  # disk3owner  = ""  # Secondary Unix ID that will own the mount
  # disk3group  = ""  # Unix group that will on the mount 
  # disk3perms  = ""  # Octal permissions notation to be applied to the mount
  # -----------
  # disk4sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk4mntpt  = ""  # Mount point for the disk, starts with /
  # disk4owner  = ""  # Secondary Unix ID that will own the mount
  # disk4group  = ""  # Unix group that will on the mount 
  # disk4perms  = ""  # Octal permissions notation to be applied to the mount
  # -----------  
  # disk5sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk5mntpt  = ""  # Mount point for the disk, starts with /
  # disk5owner  = ""  # Secondary Unix ID that will own the mount
  # disk5group  = ""  # Unix group that will on the mount 
  # disk5perms  = ""  # Octal permissions notation to be applied to the mount
  # -----------
  # disk6sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk6mntpt  = ""  # Mount point for the disk, starts with /
  # disk6owner  = ""  # Secondary Unix ID that will own the mount
  # disk6group  = ""  # Unix group that will on the mount 
  # disk6perms  = ""  # Octal permissions notation to be applied to the mount
  # -----------
  # disk7sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk7mntpt  = ""  # Mount point for the disk, starts with /
  # disk7owner  = ""  # Secondary Unix ID that will own the mount
  # disk7group  = ""  # Unix group that will on the mount 
  # disk7perms  = ""  # Octal permissions notation to be applied to the mount
  # -----------
  # disk8sizegb = ""  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  # disk8mntpt  = ""  # Mount point for the disk, starts with /
  # disk8owner  = ""  # Secondary Unix ID that will own the mount
  # disk8group  = ""  # Unix group that will on the mount 
  # disk8perms  = ""  # Octal permissions notation to be applied to the mount
}

output "linux_odi_app_server_info" {
  value = {
    for instance in optumvm_linuxvm.linux_odi_app:
    instance.servername => instance.*
  }
}