
resource "optumvm_linuxvm" "linux_odi_0" {

  # OS Building ----------------------------------------------------
  image = ""  # options are 'v8-rhel-8', 'v8-rhel-7', 'v8-centos-7'
  # ----------------------------------------------------------------

  # Edited by builder: Can mod for Day 2 Actions
  cpu                = "1"        # Options are 1 - 16
  memory             = "4"        # Options are 4 - 128 using only EVEN numbers
  # Disk 1 will always get created see disk section below
  requestedfor       = "${var.tf1211}${var.TFVAR_odi_requestedfor}"             # modded to NOT have @ms.ds.uhc.com
  sharedaccessgroup  = "${var.tf1211}${var.TFVAR_odi_sharedaccessgroup}"        # Required for initial build now

  # Maintenance Window name value pairs
  maintenancegroup         = ""  # Optional with options of DEV=0 or 1, TEST=0 or 1, STAGE=0 or 2, PROD=0 or 3
  maintenancerebootwindow  = ""  # Options "" for none, Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
  maintenancereboottime    = ""  # Options "" for none, 00:00:00-23:50:00 in 10 minute increments (start time of 4 hour block)

  # Edited by builder: CANNOT MOD for day 2
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
  reason              = "${var.tf1211}${var.TFVAR_odi_reason}"
  vraenv              = "${var.tf1211}${var.TFVAR_odi_vraenv}"

  # Uncomnment the disk blocks you need to provision in order and update and Do not skip disk blocks when uncommenting
  # -----------
  # Disk 1 will ALWAYS be created even if commented out
  disk1sizegb   = "10"  # Disk 1 can be sized 10GB-4TB, Disks 2-8 can be sized 1GB-4TB
  disk1mntpt    = "/"   # Mount point for the disk, starts with /
  disk1owner    = ""    # Secondary Unix ID that will own the mount
  disk1group    = ""    # Unix group that will on the mount                                    
  disk1perms    = "755" # Octal permissions notation to be applied to the mount
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

output "linux_odi_0_servername" {
  value = "${optumvm_linuxvm.linux_odi_0.servername}"
}

output "linux_odi_0_ipaddress" {
  value = "${optumvm_linuxvm.linux_odi_0.ipaddress}"
}

output "linux_odi_0_image_used" {
  value = "${optumvm_linuxvm.linux_odi_0.image}"
}

output "linux_odi_0_cpu" {
  value = "${optumvm_linuxvm.linux_odi_0.cpu}"
}

output "linux_odi_0_memory" {
  value = "${optumvm_linuxvm.linux_odi_0.memory}"
}

output "linux_odi_0_targetenv" {
  value = "${optumvm_linuxvm.linux_odi_0.targetenv}"
}

output "linux_odi_0_datacenter" {
  value = "${optumvm_linuxvm.linux_odi_0.datacenter}"
}

output "linux_odi_0_networkzone" {
  value = "${optumvm_linuxvm.linux_odi_0.networkzone}"
}