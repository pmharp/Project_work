resource "optumnetwork_ltm" "net_ltm_only_0" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumnetwork/Network_LTM.html#ltm-matrix
  device_names     = ["elr2hz1-00-apic1-oob","elr2hz1-00-apic2-oob","elr2hz1-00-apic3-oob"]    # Name of the target devices.  ShortName or FQDN, case insensitive
  fqdn             = "elr2hz1-apics.uhc.com"      # FQDN of the LTM
  data_center      = "ELR"      # Options are 'CTC' or 'ELR' where servers and the ltm are located
  line_of_business = "Optum Financial Services"      # LOB 
  is_public        = "FALSE" # TRUE=DMZ Presentation zone devices, FALSE when devices in Intranet or DMZ-App, DB or Tools zones, 

  ownership_details = {
    adminGroup     = "DC_Network_Engineering_and_Support"   # Global Group - CASE matters need to be less than 40 members
    msid           = "mpembert"   # MSID of the owner
  }

  ltmdetails = {
    portType   = "HTTPS"              
    lbPort     = "Port 443"
    lbMethod   = "Predictive"
    serverPort = "443"
  }

  domain_config = {
    persistence           = "Source IP address (30 min timeout)"   # options are "None", "Source IP address (10 min timeout)", "Source IP address (30 min timeout)", "Source IP address (60 min timeout)", "Cookie (session)"
    isPassSourceIPAddress = "FALSE"   # Pass Source IP Address (x-Forward-for)

    # if portType="HTTPS" updte following
    isSslRedirect         = "TRUE"          
    isSslOffload          = "TRUE"          
    siteDownText          = "Site is down"  
    sANs                  = ""
    rewriteRedirect       = "None"   # options are "All", "Matching", "None"    
    isExternalFacing      = "FALSE"  # FALSE is UHG, TRUE is External Certificate Authority
    ciphers               = "/Common/eis_approved_ciphers_v001"
  }

  health_check = {
    customPort        = ""   # if left blank it defaults to the serverport value (from above)
    intervalInSeconds = "5"
    timeoutInSeconds  = "300"
    poolMonitorType   = "ICMP"

    # If poolMonitorType is HTTP, fill these out
    httpPath     = "/"
    httpResponse = "200 OK" # Options are "200 OK" or "Search Text"
    isHttps      = "FALSE"
    searchText   = ""       # Must have valid value if httpResponse above is "Search Text"

    # If poolMonitorType is TCP, fill these out
    sendTcp          = ""
    receiveTcp       = ""
    isTcpHalfOpen    = ""
   }
}

output "net_ltm_only_0_id" {
  value = "${optumnetwork_ltm.net_ltm_only_0.id}"
}
output "net_ltm_only_0_requestid" {
  value = "${optumnetwork_ltm.net_ltm_only_0.requestid}"
}
output "net_ltm_only_0_scheduled" {
  value = "${optumnetwork_ltm.net_ltm_only_0.scheduled}"
}