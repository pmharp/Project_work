
# ---------------------------------------------------------------------------------------------------------------------------------
# ODI WEB/APP and/or DB mapping Items
# ------------------------------------------------------------------------------------------
TFVAR_odi_askid                = "UHGWM110-016291" # example UHGWM110-017540
TFVAR_odi_ppmoprojectnum       = "PRJ272506"         # Optional: If entered needs to be valid PRJ, and not OFE
TFVAR_odi_ppmoapplicationname  = "BAI"         # Optional: If entered needs to be valid ASK PRJ NAME (EXACT text)
TFVAR_odi_requestedfor         = "pharp"    # DAY2_MOD: MSID, Leave off the @ms.ds.uhc.com
TFVAR_odi_sharedaccessgroup    = "Mountaineers"  # DAY2_MOD: Required: Non-Privileged AD Group to be filled in at initial build time
TFVAR_odi_targetenv            = "STAGE"     # Options: 'DEV', 'TEST', 'STAGE', 'PROD'
TFVAR_odi_datacenter           = "mn011"    # Options: 'mn011' (Chaska) or 'mn053' (Elk River)
TFVAR_odi_availabilityzone     = "aza"      # Options: 'aza', 'azb'
TFVAR_odi_networkzone          = "CORE"     # Options: 'CORE'
TFVAR_odi_interfacezone        = "INTERNAL" # Options: 'INTERNAL'
TFVAR_odi_drcode               = "NO-DR"   # Options: 'NO-DR' and 'DR-303' is allowed if ASKID has DR designation

# RHEL Specific Items
TFVAR_odi_privunixid           = ""         # Secondary UNIX ID: Able to login and has Admin Rights
TFVAR_odi_privuserunixgroup    = ""         # Optional: Unix Group able to login and has Admin Rights (DCE cannot be used)
TFVAR_odi_nonprivunixid        = ""         # Optional: Secondary UNIX ID: Able to login only - NO ADMIN rights
TFVAR_odi_nonprivuserunixgroup = ""         # Optional: Unix Group able to login only - NO ADMIN rights (DCE cannot be used)

# Windows Specific Items
TFVAR_odi_privadid             = "pharp101"        # Secondary (domain specific) ID to Admin Windows devices (Ids are from MS or DMZMGMT)
TFVAR_odi_privuseradgroup      = "SED_ARK"         # Privileged AD Group that TFVAR_odi_privadid is part of to admin of windows devices
# ---------------------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------------------
# Linux Web Layer
# ------------------------------------------------------------------------------------------
TFVAR_linux_web_count  = "0"               # Number of Linux WEB servers to build
TFVAR_linux_web_image  = "v8-rhel-8"       # Options: 'v8-rhel-8', 'v8-rhel-7', 'v8-centos-7'
TFVAR_linux_web_cpu    = "1"               # DAY2_MOD: Options are 1 - 16 using only EVEN numbers
TFVAR_linux_web_memory = "4"               # DAY2_MOD: Options are 4 - 128 using only EVEN numbers
TFVAR_linux_web_reason = "Linux Web Svr"   # Value displayed in tech.optum.com / odi_getvmdetails utility 

# ------------------------------------------------------------------------------------------
# Linux App Layer - BASE
# ------------------------------------------------------------------------------------------
TFVAR_linux_app_count  = "0"               # Number of Linux APP servers to build
TFVAR_linux_app_image  = "v8-rhel-8"       # Options: 'v8-rhel-8', 'v8-rhel-7', 'v8-centos-7'
TFVAR_linux_app_cpu    = "1"               # DAY2_MOD: Options are 1 - 16 using only EVEN numbers
TFVAR_linux_app_memory = "4"               # DAY2_MOD: Options are 4 - 128 using only EVEN numbers
TFVAR_linux_app_reason = "Linux App Svr"   # Value displayed in tech.optum.com / odi_getvmdetails utility

# # ------------------------------------------------------------------------------------------
# # Linux App Layer - JBOSS
# # ------------------------------------------------------------------------------------------
# TFVAR_linux_jboss_count   = "0"                 # Number of Linux JBOSS servers to build
# TFVAR_linux_jboss_image   = "v8-rhel-8"         # Options: 'v8-rhel-8', 'v8-rhel-7'
# TFVAR_linux_jboss_cpu     = "2"                 # DAY2_MOD: Options are 2 - 16 using only EVEN numbers
# TFVAR_linux_jboss_memory  = "4"                 # DAY2_MOD: Options are 4 - 128 using only EVEN numbers
# TFVAR_linux_jboss_lobname = ""                  # Options: 
#                                                   # "LOB Internal DO_NOT_USE"  
# TFVAR_linux_jboss_version = "7.2.9"             # Options are '7.2.9'
# TFVAR_linux_jboss_reason  = "Linux jboss Svr"   # Value displayed in tech.optum.com / odi_getvmdetails utility

# # ------------------------------------------------------------------------------------------
# # Linux App Layer - WILDFLY
# # ------------------------------------------------------------------------------------------
# TFVAR_linux_wildfly_count   = "0"                 # Number of Linux wildfly servers to build
# TFVAR_linux_wildfly_image   = "v8-rhel-8"         # Options: 'v8-rhel-8', 'v8-rhel-7', 'v8-centos-7
# TFVAR_linux_wildfly_cpu     = "2"                 # DAY2_MOD: Options are 2 - 16 using only EVEN numbers
# TFVAR_linux_wildfly_memory  = "4"                 # DAY2_MOD: Options are 4 - 128 using only EVEN numbers
# TFVAR_linux_wildfly_lobname = ""                  # Options: 
#                                                   # "LOB Internal DO_NOT_USE"  
# TFVAR_linux_wildfly_version = "20.0.0"            # Options are '20.0.0'
# TFVAR_linux_wildfly_reason  = "Linux wildfly Svr" # Value displayed in tech.optum.com / odi_getvmdetails utility

# ------------------------------------------------------------------------------------------
# Linux DB Layer - Builds on RHEL 7 - MYSQL STAND ALONE <<<---
# ------------------------------------------------------------------------------------------
TFVAR_linux_db_mysql_sa_count             = "0"               # Number of Stand Alone DB servers to build
TFVAR_linux_db_mysql_sa_image             = "v8-rhel-7"       # Options: 'v8-rhel-7'
TFVAR_linux_db_mysql_sa_cpu               = "2"               # DAY2_MOD: Options are 2,4,6,8 Only
TFVAR_linux_db_mysql_sa_memory            = "4"               # DAY2_MOD: Range is 4-128 GB
TFVAR_linux_db_mysql_sa_lobname           = ""                # Options: 
                                                                # "Community & State", "Employer & Individual and Clinical Services", "Medicare & Retirement", "Optum Call Center Services (CCS)"
                                                                # "Optum Corporate and Shared Services", "Optum ET Oracle and MySQL", " Optum Insight and PEDS - MySQL", "OptumRX DB MYSQL"
                                                                # "UHC Core Services", "UHG Corp", "LOB Internal DO_NOT_USE"  
TFVAR_linux_db_mysql_sa_mysqldbversion    = "8.0"             # Options: "5.7", "8.0"
TFVAR_linux_db_mysql_sa_mysqldatabasename = ""                # Lowercase Alphanumeric values with length 6-64
TFVAR_linux_db_mysql_sa_databasesize      = ""                # Range is 10-1024 GB
TFVAR_linux_db_mysql_sa_phi               = "No"              # Options: "Yes", "No"                                      
TFVAR_linux_db_mysql_sa_pii               = "No"              # Options: "Yes", "No"
# TFVAR_linux_db_mysql_sa_reason          = "Linux SA DB Svr" # Not Used currently

# ------------------------------------------------------------------------------------------
# Linux DB Layer - Builds STAGE/PROD RHEL 7 - MySQL 3 NODE CLUSTER <<<---
# ------------------------------------------------------------------------------------------
TFVAR_linux_db_mysql_cls_count             = "0"                # Number of 3node mySQL Clusters to build
TFVAR_linux_db_mysql_cls_image             = "v8-rhel-7"        # Options: 'v8-rhel-7'
TFVAR_linux_db_mysql_cls_cpu               = "2"                # DAY2_MOD: Options are 2,4,6,8 Only
TFVAR_linux_db_mysql_cls_memory            = "4"                # DAY2_MOD: Range is 4-128 GB
TFVAR_linux_db_mysql_cls_lobname           = ""                 # Options: 
                                                                    # "Community & State", "Employer & Individual and Clinical Services", "Medicare & Retirement", "Optum Call Center Services (CCS)"
                                                                    # "Optum Corporate and Shared Services", "Optum ET Oracle and MySQL", " Optum Insight and PEDS - MySQL", "OptumRX DB MYSQL"
                                                                    # "UHC Core Services", "UHG Corp", "LOB Internal DO_NOT_USE"  
TFVAR_linux_db_mysql_cls_mysqldbversion    = "8.0"              # Options: "5.7", "8.0"
TFVAR_linux_db_mysql_cls_mysqldatabasename = ""                 # Lowercase Alphanumeric values with length 6-64
TFVAR_linux_db_mysql_cls_databasesize      = ""                 # Range is 10-1024 GB
TFVAR_linux_db_mysql_cls_phi               = "No"               # Options: "Yes", "No"                                      
TFVAR_linux_db_mysql_cls_pii               = "No"               # Options: "Yes", "No"
# TFVAR_linux_db_mysql_cls_reason          = "Linux DB CLS Svr" # Not Used currently

# # ------------------------------------------------------------------------------------------
# # Linux DB Layer - Builds on RHEL 7 / Centos 7 - POSTGRESQL STAND ALONE <<<---
# # ------------------------------------------------------------------------------------------
# TFVAR_linux_db_postgresql_sa_count                  = "0"                       # Number of Stand Alone DB servers to build
# TFVAR_linux_db_postgresql_sa_image                  = "v8-rhel-7"               # Options: 'v8-rhel-7'
# TFVAR_linux_db_postgresql_sa_cpu                    = "2"                       # DAY2_MOD: Options are 2,4,6,8 Only
# TFVAR_linux_db_postgresql_sa_memory                 = "4"                       # DAY2_MOD: Range is 4-128 GB
# TFVAR_linux_db_postgresql_sa_lobname                = ""                        # Options: 
#                                                                                     # "Community & State", "Employer & Individual and Clinical Services", 
#                                                                                     # "Medicare & Retirement", "Optum Call Center Services (CCS)"
#                                                                                     # "Optum Corporate and Shared Services", "Optum ET Oracle and MySQL", 
#                                                                                     # " Optum Insight and PEDS - MySQL", "OptumRX DB MYSQL"
#                                                                                     # "UHC Core Services", "UHG Corp", "LOB Internal DO_NOT_USE"  
# TFVAR_linux_db_postgresql_sa_postgresqldbversion    = "8.0"                     # Options: "5.7", "8.0"
# TFVAR_linux_db_postgresql_sa_postgresqldatabasename = ""                        # Lowercase Alphanumeric values with length 6-64
# TFVAR_linux_db_postgresql_sa_postgresqldatabasesize = ""                        # Range is 10-1024 GB
# TFVAR_linux_db_postgresql_sa_phi                    = "No"                      # Options: "Yes", "No"                                      
# TFVAR_linux_db_postgresql_sa_pii                    = "No"                      # Options: "Yes", "No"
# TFVAR_linux_db_postgresql_sa_reason                 = "PostGreSQL SA DB Svr"    # Not Used currently
# ---------------------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------------------
# Windows Web Layer
# ------------------------------------------------------------------------------------------
TFVAR_windows_web_count  = "0"               # Number of Windows WEB servers to build
TFVAR_windows_web_image  = "v8-w2019"        # Options: 'v8-w2019', 'v8-w2016'
TFVAR_windows_web_cpu    = "2"               # DAY2_MOD: Options are 1 - 16 using only EVEN numbers
TFVAR_windows_web_memory = "32"               # DAY2_MOD: Options are 4 - 128 using only EVEN numbers
TFVAR_windows_web_reason = "Windows Web Svr" # Value displayed in tech.optum.com / odi_getvmdetails utility

# ------------------------------------------------------------------------------------------
# Windows App Layer
# ------------------------------------------------------------------------------------------
#TFVAR_windows_app_count  = "0"              # Number of Windows APP servers to build
TFVAR_windows_app_image  = "v8-w2019"        # Options: 'v8-w2019', 'v8-w2016'
#TFVAR_windows_app_cpu    = "2"               # DAY2_MOD: Options are 1 - 16 using only EVEN numbers
#TFVAR_windows_app_memory = "32"              # DAY2_MOD: Options are 4 - 128 using only EVEN numbers
TFVAR_windows_app_reason = "Windows APP Svr" # Value displayed in tech.optum.com / odi_getvmdetails utility

# ------------------------------------------------------------------------------------------
# Windows DB Layer - Builds Win2019/msSQL19 or Win2016/msSQL16 - MsSQL STAND ALONE <<<---
# ------------------------------------------------------------------------------------------
TFVAR_windows_db_mssql_sa_count                  = "0"                    # Number of Windows DB servers to build
TFVAR_windows_db_mssql_sa_cpu                    = "2"                    # DAY2_MOD: Options are 2-16, even values only
TFVAR_windows_db_mssql_sa_memory                 = "8"                    # DAY2_MOD: Range is 8-128 GB, even values only
TFVAR_windows_db_mssql_sa_lobname                = ""                     # Options: 
                                                                            # "Community & State", "Employer & Individual and Clinical Services", "Medicare & Retirement", 
                                                                            # "Optum Call Center Services (CCS)", "Optum Corporate and Shared Services", "Optum ET SQL Server and APS"
                                                                            # "Optum Insight and PEDS - SQL", "OptumRX DB MSSQL", "UHC Core Services", "UHG Corp", "LOB Internal DO_NOT_USE"
TFVAR_windows_db_mssql_sa_sqlserverdbversion     = ""                     # Options: "2019", "2016"
TFVAR_windows_db_mssql_sa_dbcollation            = "Latin1_General_CI_AS" # Options: 
                                                                            # "Latin1_General_CI_AS", "SQL_Latin1_General_CP1_CI_AS", "Latin1_General_BIN", "Latin1_General_CI_AS_KS_WS"
                                                                            # "SQL_Latin1_General_CP1_CI_AI", "Latin1_General_CI_AI", "SQL_Latin1_General_CP1_CS_AS", "Latin1_General_BIN2"
TFVAR_windows_db_mssql_sa_sqlserverdatabasename  = ""                     # Lowercase Alphanumeric values with length 1-64
TFVAR_windows_db_mssql_sa_databasesize           = ""                     # Range is 1-3072 GB
TFVAR_windows_db_mssql_sa_sqlserverdatabaseowner = ""                     # Primary MS ID
TFVAR_windows_db_mssql_sa_dbaccessgroup          = ""                     # AD Group above MS ID is a member of
TFVAR_windows_db_mssql_sa_phi                    = "No"                   # Options: "Yes", "No"                                                                       
TFVAR_windows_db_mssql_sa_pii                    = "No"                   # Options: "Yes", "No" 
# TFVAR_windows_db_mssql_sa_reason               = "Windows DB SA Svr"    # Not Used currently
# TFVAR_windows_db_mssql_sa_image                = ""                     # Uses sqlserverdbversion to determine WIN OS version 
# ------------------------------------------------------------------------------------------
# Windows DB Layer - Builds STAGE/PROD Win2016/msSQL16 - MsSQL 3 NODE CLUSTER <<<---
# ------------------------------------------------------------------------------------------
TFVAR_windows_db_mssql_cls_count                  = "0"                    # Number of Windows DB servers to build
TFVAR_windows_db_mssql_cls_cpu                    = "8"                    # DAY2_MOD: Options are 4-16, even values only
TFVAR_windows_db_mssql_cls_memory                 = "32"                    # DAY2_MOD: Range is 8-128 GB, even values only
TFVAR_windows_db_mssql_cls_lobname                = "UHC Core Services"                     # Options: 
                                                                            # "Community & State", "Employer & Individual and Clinical Services", "Medicare & Retirement", 
                                                                            # "Optum Call Center Services (CCS)", "Optum Corporate and Shared Services", "Optum ET SQL Server and APS"
                                                                            # "Optum Insight and PEDS - SQL", "OptumRX DB MSSQL", "UHC Core Services", "UHG Corp", "LOB Internal DO_NOT_USE"
TFVAR_windows_db_mssql_cls_sqlserverdbversion     = "2019"                     # Options: "2016, 2019"     
TFVAR_windows_db_mssql_cls_dbcollation            = "Latin1_General_CI_AS" # Options: 
                                                                            # "Latin1_General_CI_AS", "SQL_Latin1_General_CP1_CI_AS", "Latin1_General_BIN", "Latin1_General_CI_AS_KS_WS"
                                                                            # "SQL_Latin1_General_CP1_CI_AI", "Latin1_General_CI_AI", "SQL_Latin1_General_CP1_CS_AS", "Latin1_General_BIN2"
TFVAR_windows_db_mssql_cls_sqlserverdatabasename  = "RFDEV202"                     # Lowercase Alphanumeric values with length 1-64
TFVAR_windows_db_mssql_cls_databasesize           = "30"                     # Range is 1-3072 GB
TFVAR_windows_db_mssql_cls_sqlserverdatabaseowner = "kprice26"                     # Primary MS ID
TFVAR_windows_db_mssql_cls_dbaccessgroup          = "RightFax"                     # AD Group above MS ID is a member of
TFVAR_windows_db_mssql_cls_phi                    = "No"                   # Options: "Yes", "No"                                                                       
TFVAR_windows_db_mssql_cls_pii                    = "No"                   # Options: "Yes", "No" 
# TFVAR_windows_db_mssql_cls_reason               = "Windows DB CLS Svr"   # Not Used currently
# TFVAR_windows_db_mssql_cls_image                = ""                     # Uses sqlserverdbversion to determine WIN OS version 
# ---------------------------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------------------------
# NON-Changing Values
# ------------------------------------------------------------------------------------------
TFVAR_odi_apptag = "None"     # Options: 'None', used by backend systems for mySQL, msSQL
TFVAR_odi_vraenv = "prod"
# ---------------------------------------------------------------------------------------------------------------------------------





