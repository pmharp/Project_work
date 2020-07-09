# Frequently changed Value acress all Files 
TFVAR_NAMESPACE = "OSFI_NAMESPACE"
TFVAR_OSFI_SVCACCT_TOKEN = "SVCACCT_TOKEN_TF"
TFVAR_CONTAINER = "OSFI_CONTAINER_NAME"
TFVAR_IMAGE_URL = "IMAGE_REPO_URL/IMAGE_REPO_NAMESPACE/IMAGE_NAME:IMAGE_TAG"
TFVAR_CONTAINER_EXPOSED_PORT = "IMAGE_EXP_PORT"

# TFVAR_DATACENTER_URL info for K8 and OKD
# K8 -  CTC Core  = "https://10.202.2.252:6443"
# K8 -  ELR Core  = "https://10.49.2.252:6443"                                 
# K8 -  PTC Core  = "https://10.111.2.252:6443"

# OKD - CTC Core Non-Prod = "https://ocp-ctc-core-nonprod.optum.com"
# OKD - CTC Core Prod     = "https://origin-ctc-core.optum.com"
# OKD - ELR Core Non-Prod = "https://ocp-elr-core-nonprod.optum.com"
# OKD - ELR Core Prod     = "https://origin-elr-core.optum.com"

TFVAR_DATACENTER_URL = "OSFI_DATACENTER_URL"

# TFVAR_OSFI_CERTIFICATE info for K8 and OSE
# K8 - CTC = "certs/k8_ca_ctc_all.crt"
# K8 - ELR = "certs/k8_ca_elr_all.crt"          
# K8 - PTC = "certs/k8_ca_ptc_all.crt"

# OKD - CTC Non-Prod = "certs/okd_ca_ctc_nonprd.crt" 
# OKD - CTC Prod     = "certs/okd_ca_ctc_stgprd.crt"    (Prod includes Stage)
# OKD - ELR Nonprd   = "certs/okd_ca_elr_nonprd.crt"
# OKD - ELR Prod     = "certs/okd_ca_elr_stgprd.crt"    (Prod includes Stage)

TFVAR_OSFI_CERTIFICATE = "certs/OSFI_CERTIFICATE_TF" 

TFVAR_REPLICA_COUNT = "OSFI_REPLICA_COUNT" # number of replicas you would like to provision 1 to ??
