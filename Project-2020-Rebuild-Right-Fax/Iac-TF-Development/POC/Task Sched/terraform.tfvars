
# ------------------------------------------------------------------------------------------
# VRA 7 LEGACY SECTION
# ------------------------------------------------------------------------------------------
# Frequently changed Value across all Files
TFVAR_requestedfor          = "kprice26"         # Leave off the @ms.ds.uhc.com
TFVAR_askid                 = ""                 # example UHGWM110-020897
TFVAR_targetenv             = ""                 # Options are DEV, TEST, STAGE, PROD"  
TFVAR_datacenter            = ""                 # Options are CTC or ELR" 
TFVAR_resiliencyzone        = "No Preference"    # Options are  'No Preference' the 'RZ=x'
TFVAR_networkzone           = "intranet"         # Options are  intranet, internet
TFVAR_interfacezone         = "Intranet"         # Options are  Intranet, Presentation, Application, Database, Tools
TFVAR_drcode                = "DR-000"           # Options are DR-000, DR-102, DR-111"
TFVAR_drrto                 = ""                 # Options "" for DRs other than DR-303, If drcode="DR-303", then options are RTO-08,RTO-24,RTO-48,RTO-72
TFVAR_vradescription        = "Collective Task Sched Built" # Used across all TF files
TFVAR_vrasharedaccessgroup  = "Change24hrsAfterBuild"
TFVAR_ppmoprojnum           = ""                 # Enter Project number if applicable, Optional field
TFVAR_maintenancegroup      = ""                 # Options "" for none, "1", "2" for dev/test, "3", "4" for stage/prod (week of the month)
TFVAR_maintenancerebootday  = ""                 # Options "" for none, Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday
TFVAR_maintenancereboothour = ""                 # Options "" for none, 00:00-23:50 in 10 minute increments (start time of 4 hour block)

# RSO specific common variables
TFVAR_2ndunixid             = "2NDUNIXID"       # Secondary UNIX ID for admin LINUX devices
TFVAR_2ndadid               = "2NDADID"         # Secondary (domain specific) ID to Admin Windows devices (Ids are from MS or DMZMGMT)
TFVAR_adprivilegedgg        = "ADPRIVILEGEDGG"  # Privileged AD Group that 2ndadid is part of to admin of windows devices

# Not asked for in PS files these are needed, but should not be changed
TFVAR_vrareasons            = "Needed By app"
TFVAR_sedsupport            = "Yes"
TFVAR_vraenv                = "prod"
TFVAR_useserviceaccount     = "yes"

# Agreements for IAAS and PAAS
TFVAR_paasagree             = "yes"
TFVAR_iaasagree             = "yes"
# ------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------------------
# ODI SECTION
# ------------------------------------------------------------------------------------------
TFVAR_odi_apptag               = "None"             # Only valid Option 'None'
TFVAR_odi_askid                = "UHGWM110-016291"  # example UHGWM110-020897
TFVAR_odi_ppmoprojectnum       = ""                 # Optional field, if entered needs to be valid PRJ
TFVAR_odi_ppmoapplicationname  = ""                 # Optional field, if entered needs to be valid ASK PRJ NAME (EXACT text)
TFVAR_odi_requestedfor         = "kprice27"         # Leave off the @ms.ds.uhc.com
TFVAR_odi_sharedaccessgroup    = "rightfax_ark"     # AD group used to manage VM resources and ownership
TFVAR_odi_targetenv            = "DEV"              # Options DEV, TEST, STAGE, PROD"  
TFVAR_odi_datacenter           = "mn053"            # Options mn011(Chaska) or mn053(Elk River)" 
TFVAR_odi_availabilityzone     = "aza"              # Options 'aza', 'azb' or 'azt' (DEV)
TFVAR_odi_networkzone          = "CORE"             # Options 'CORE', 'DMZ-APP', 'DMZ-DB', 'DMZ-WEB','DMZ-TOOLS'
TFVAR_odi_interfacezone        = "INTERNAL"         # Options 'INTERNAL'
TFVAR_odi_drcode               = "NO-DR"            # Options NO-DR, DR-303 (PROD)

# RSO specific common variables - RHEL
TFVAR_odi_privunixid           = "2NDUNIXID"   # Secondary UNIX ID: Able to login and has Admin Rights
TFVAR_odi_privuserunixgroup    = "dce"         # Unix Group able to login and has Admin Rights
TFVAR_odi_nonprivunixid        = "2NDUNIXID"   # Secondary UNIX ID: Able to login only - NO ADMIN rights
TFVAR_odi_nonprivuserunixgroup = "dce"         # Unix Group able to login only - NO ADMIN rights

# RSO specific common variables - WINDOWS
TFVAR_odi_privadid          = "pharp101"       # Secondary (domain specific) ID to Admin Windows devices (Ids are from MS or DMZMGMT)
TFVAR_odi_privuseradgroup   = "SED_ARK"        # Privileged AD Group that privadid is part of to admin of windows devices

# Not asked for in PS files these are needed, but should not be changed
TFVAR_odi_reason  = "Needed By app"
TFVAR_odi_vraenv  = "PROD"

# ------------------------------------------------------------------------------------------