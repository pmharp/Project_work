resource "optumnetwork_dns" "net_dns_alias_0" { 
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumnetwork/Network_DNS.html#dns-alias-matrix
  aliasname      = ""   # FQDN of the CNAME Record (alias) to be created 
  targetfqdn     = ""   # FQDN of the existing A Record for the target device
  dnsenvironment = ""   # Options are 'UHG Internal' or 'UHG External' 
  requestormsid  = ""   # msid of the requestor 
  admingroup     = ""   # AD Global Group, 40 members or less, requestormsid must be member
} 

output "net_dns_alias_0_id" {
  value = "${optumnetwork_dns.net_dns_alias_0.id}"
}
output "net_dns_alias_0_requestid" {
  value = "${optumnetwork_dns.net_dns_alias_0.requestid}"
}