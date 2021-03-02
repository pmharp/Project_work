# ------------------------------------------------------------------------------------------
# ODI WEB/APP and/or DB mapping Items
# ------------------------------------------------------------------------------------------
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

# RHEL Specific Items
variable "TFVAR_odi_privunixid"  { default ="" }
variable "TFVAR_odi_privuserunixgroup"  { default ="" }
variable "TFVAR_odi_nonprivunixid"  { default ="" }
variable "TFVAR_odi_nonprivuserunixgroup"  { default ="" }

# Windows Specific Items
variable "TFVAR_odi_privadid"  { default ="" }
variable "TFVAR_odi_privuseradgroup"  { default ="" }
# ------------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------------
# Linux Web Layer
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_web_count"  { default ="" }
variable "TFVAR_linux_web_image"  { default ="" }
variable "TFVAR_linux_web_cpu"  { default ="" }
variable "TFVAR_linux_web_memory"  { default ="" }
variable "TFVAR_linux_web_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Linux App Layer - BASE
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_app_count"  { default ="" }
variable "TFVAR_linux_app_image"  { default ="" }
variable "TFVAR_linux_app_cpu"  { default ="" }
variable "TFVAR_linux_app_memory"  { default ="" }
variable "TFVAR_linux_app_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Linux App Layer - JBOSS
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_jboss_count"  { default ="" }
variable "TFVAR_linux_jboss_image"  { default ="" }
variable "TFVAR_linux_jboss_cpu"  { default ="" }
variable "TFVAR_linux_jboss_memory"  { default ="" }
variable "TFVAR_linux_jboss_lobname"  { default ="" }
variable "TFVAR_linux_jboss_version"  { default ="" }
variable "TFVAR_linux_jboss_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Linux App Layer - WILDFLY
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_wildfly_count"  { default ="" }
variable "TFVAR_linux_wildfly_image"  { default ="" }
variable "TFVAR_linux_wildfly_cpu"  { default ="" }
variable "TFVAR_linux_wildfly_memory"  { default ="" }
variable "TFVAR_linux_wildfly_lobname"  { default ="" }
variable "TFVAR_linux_wildfly_version"  { default ="" }
variable "TFVAR_linux_wildfly_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Linux DB Layer - MySQL STAND ALONE <<<---
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_db_mysql_sa_count"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_image"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_cpu"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_memory"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_lobname"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_mysqldbversion"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_mysqldatabasename"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_databasesize"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_phi"  { default ="" }
variable "TFVAR_linux_db_mysql_sa_pii"  { default ="" }
# variable "TFVAR_linux_db_mysql_sa_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Linux DB Layer - MySQL 3 NODE CLUSTER <<<---
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_db_mysql_cls_count"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_image"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_cpu"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_memory"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_lobname"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_mysqldbversion"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_mysqldatabasename"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_databasesize"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_phi"  { default ="" }
variable "TFVAR_linux_db_mysql_cls_pii"  { default ="" }
# variable "TFVAR_linux_db_mysql_cls_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Linux DB Layer - PostGreSQL STAND ALONE <<<---
# ------------------------------------------------------------------------------------------
variable "TFVAR_linux_db_postgresql_sa_count"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_image"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_cpu"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_memory"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_lobname"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_postgresqldbversion"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_postgresqldatabasename"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_postgresqldatabasesize"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_phi"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_pii"  { default ="" }
variable "TFVAR_linux_db_postgresql_sa_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Windows Web Layer
# ------------------------------------------------------------------------------------------
variable "TFVAR_windows_web_count"  { default ="" }
variable "TFVAR_windows_web_image"  { default ="" }
variable "TFVAR_windows_web_cpu"  { default ="" }
variable "TFVAR_windows_web_memory"  { default ="" }
variable "TFVAR_windows_web_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Windows App Layer
# ------------------------------------------------------------------------------------------
variable "TFVAR_windows_app_count"  { default ="" }
variable "TFVAR_windows_app_image"  { default ="" }
variable "TFVAR_windows_app_cpu"  { default ="" }
variable "TFVAR_windows_app_memory"  { default ="" }
variable "TFVAR_windows_app_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Windows DB Layer - MsSQL STAND ALONE <<<---
# ------------------------------------------------------------------------------------------
variable "TFVAR_windows_db_mssql_sa_count"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_image"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_cpu"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_memory"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_lobname"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_sqlserverdbversion"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_dbcollation"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_sqlserverdatabasename"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_databasesize"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_sqlserverdatabaseowner"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_dbaccessgroup"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_phi"  { default ="" }
variable "TFVAR_windows_db_mssql_sa_pii"  { default ="" }
# variable "TFVAR_windows_db_mssql_sa_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# Windows DB Layer - MsSQL 3 NODE CLUSTER <<<---
# ------------------------------------------------------------------------------------------
variable "TFVAR_windows_db_mssql_cls_count"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_image"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_cpu"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_memory"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_lobname"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_sqlserverdbversion"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_dbcollation"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_sqlserverdatabasename"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_databasesize"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_sqlserverdatabaseowner"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_dbaccessgroup"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_phi"  { default ="" }
variable "TFVAR_windows_db_mssql_cls_pii"  { default ="" }
# variable "TFVAR_windows_db_mssql_cls_reason"  { default ="" }

# ------------------------------------------------------------------------------------------
# NON-Changing Values
# ------------------------------------------------------------------------------------------
variable "TFVAR_odi_apptag"  { default ="" }
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

