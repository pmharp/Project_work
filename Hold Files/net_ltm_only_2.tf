resource "optumnetwork_ltm" "net_ltm_only_2" {
  # Refer to https://github.optum.com/pages/IAC-COE/terraform-provider-optumnetwork/Network_LTM.html#ltm-matrix
  device_names     = [""]    # ShortName of the target devices.  EX:  ["servernameA","ServernameB"]
  fqdn             = "IAC_MNTW"      # FQDN of the LTM
  data_center      = "ELR"      # Options are 'CTC' or 'ELR' where servers and the ltm are located
  line_of_business = "OPTUMTECH"      # LOB 
  is_public        = "FALSE" # TRUE=DMZ Presentation zone devices, FALSE when devices in Intranet or DMZ-App, DB or Tools zones, 

  ownership_details = {
    adminGroup     = "SED_ARK"   # Global Group - CASE matters need to be less than 40 members
    msid           = "pharp101"   # MSID of the owner
  }

  ltmdetails = {
    portType   = "HTTPS"              
    lbPort     = "Port 443"
    lbMethod   = "Least Connections"
    serverPort = "80"
  }

  domain_config = {
    persistence           = "Source IP address (30 min timeout)"   # options are "None", "Source IP address (10 min timeout)", "Source IP address (30 min timeout)", "Source IP address (60 min timeout)", "Cookie (session)"
    isPassSourceIPAddress = "TRUE"   # Pass Source IP Address (x-Forward-for)

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
    timeoutInSeconds  = "16"
    poolMonitorType   = "HTTP"

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

output "net_ltm_only_2_id" {
  value = "${optumnetwork_ltm.net_ltm_only_2.id}"
}
output "net_ltm_only_2_requestid" {
  value = "${optumnetwork_ltm.net_ltm_only_2.requestid}"
}
output "net_ltm_only_2_scheduled" {
  value = "${optumnetwork_ltm.net_ltm_only_2.scheduled}"
}