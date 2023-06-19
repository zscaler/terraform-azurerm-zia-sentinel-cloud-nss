locals {
  weblogs_kql = <<-WEBLOGKQLDATA
            source | project TimeGenerated,
            DeviceCustomString1Label = tostring(cs1Label) , DeviceCustomString1 = tostring(cs1) ,
            DeviceCustomString2Label = tostring(cs2Label) , DeviceCustomString2 = tostring(cs2) ,
            DeviceCustomString3Label = tostring(cs3Label) , DeviceCustomString3 = tostring(cs3) ,
            DeviceCustomString4Label = tostring(cs4Label) , DeviceCustomString4 = tostring(cs4) ,
            DeviceCustomString5Label = tostring(cs5Label) , DeviceCustomString5 = tostring(cs5) ,
            DeviceCustomString6Label = tostring(cs6Label) , DeviceCustomString6 = tostring(cs6) ,
            DeviceCustomNumber1Label = tostring(cn1Label) , DeviceCustomNumber1 = toint(cn1) ,
            FlexString1Label = tostring(flexString1Label) , FlexString1 = tostring(flexString1) ,
            FlexString2Label = tostring(flexString2Label) , FlexString2 = tostring(flexString2) ,
            requestContext  = tostring(requestContext),
            DeviceAction = tostring(act) ,
            ApplicationProtocol = tostring(app) ,
            DestinationHostName = tostring(dhost) ,
            DestinationIP = tostring(dst) ,
            SourceIP = tostring(src) ,
            RequestURL = tostring(request),
            out = toint(out),
            SentBytes = tolong(out),
            //ReceivedBytes = tolong(in),
            //in = toint(in),
            RequestClientApplication = tostring(requestClientApplication),
            RequestMethod = tostring(requestMethod),
            SourceUserName = tostring(suser),
            SourceUserPrivileges = tostring(spriv),
            ExternalID = toint(externalId),
            ExtID = tostring(externalId),
            FileType = tostring(fileType),
            DestinationServiceName = tostring(destinationServiceName),
            CommunicationDirection = tostring(deviceDirection),
            rulelabel = tostring(rulelabel) ,
            ruletype = tostring(ruletype),
            urlclass = tostring(urlclass),
            devicemodel = tostring(devicemodel),
            DeviceVendor = tostring(DeviceVendor),
            DeviceProduct = tostring(DeviceProduct),
            DeviceEventClassID=tostring(act),
            EventOutcome = tostring(outcome) ,
            Reason = tostring(reason) ,
            Activity = tostring(reason),
            SourceTranslatedAddress = tostring(sourceTranslatedAddress)
    WEBLOGKQLDATA

  dns_logs_kql = <<-DNSLOGKQLDATA
            source | project TimeGenerated,
            DeviceCustomString1Label = tostring(cs1Label) , DeviceCustomString1 = tostring(cs1) ,
            DeviceCustomString2Label = tostring(cs2Label) , DeviceCustomString2 = tostring(cs2) ,
            DeviceCustomString3Label = tostring(cs3Label) , DeviceCustomString3 = tostring(cs3) ,
            DeviceCustomString4Label = tostring(cs4Label) , DeviceCustomString4 = tostring(cs4) ,
            DeviceCustomString5Label = tostring(cs5Label) , DeviceCustomString5 = tostring(cs5) ,
            DeviceCustomString6Label = tostring(cs6Label) , DeviceCustomString6 = tostring(cs6) ,
            DeviceCustomNumber1Label = tostring(cn1Label) , DeviceCustomNumber1 = toint(cn1) ,
            FlexString1Label = tostring(flexString1Label) , FlexString1 = tostring(flexString1),
            FlexString2Label = tostring(flexString2Label) , FlexString2 = tostring(flexString2),
            SourceUserName = tostring(suser),
            DeviceAction = tostring(act) ,
            DeviceEventClassID=tostring(act)  ,
            DestinationIP = tostring(dst) ,
            SourceIP = tostring(src) ,
            SourceUserPrivileges = tostring(spriv),
            DestinationPort = toint(dpt) ,
            rulelabel = tostring(rulelabel) ,
            DeviceVendor = tostring(DeviceVendor),
            DeviceProduct = tostring(DeviceProduct),
            DeviceName = tostring(dvchost),
            Activity = tostring(act),
            Reason = tostring(rulelabel),
            cat = tostring(cat),
            SourceUserID = tostring(suid)
    DNSLOGKQLDATA

  firewall_logs_kql = <<-FWLOGKQLDATA
            source | project TimeGenerated,
            DeviceCustomString1Label = tostring(cs1Label) , DeviceCustomString1 = tostring(cs1) ,
            DeviceCustomString2Label = tostring(cs2Label) , DeviceCustomString2 = tostring(cs2) ,
            DeviceCustomString3Label = tostring(cs3Label) , DeviceCustomString3 = tostring(cs3) ,
            DeviceCustomString4Label = tostring(cs4Label) , DeviceCustomString4 = tostring(cs4) ,
            DeviceCustomString5Label = tostring(cs5Label) , DeviceCustomString5 = tostring(cs5) ,
            DeviceCustomString6Label = tostring(cs6Label) , DeviceCustomString6 = tostring(cs6) ,
            DeviceCustomNumber1Label = tostring(cn1Label) , DeviceCustomNumber1 = toint(cn1) ,
            DeviceCustomNumber2Label = tostring(cn2Label) , DeviceCustomNumber2 = toint(cn2) ,
            deviceCustomFloatingPoint1Label = tostring(cfp1Label) , DeviceCustomFloatingPoint1 = toreal(cfp1),
            FlexString1Label = tostring(flexString1Label) , FlexString1 = tostring(flexString1),
            FlexString2Label = tostring(flexString2Label) , FlexString2 = tostring(flexString2),
            DeviceAction = tostring(act) ,
            DeviceEventClassID=tostring(act)  ,
            DestinationIP = tostring(dst) ,
            SourceIP = tostring(src) ,
            SourcePort = toint(spt) ,
            DestinationPort = toint(dpt) ,
            DeviceTranslatedAddress = tostring(deviceTranslatedAddress),
            SourceTranslatedAddress = tostring(sourceTranslatedAddress),
            DestinationTranslatedAddress = tostring(destinationTranslatedAddress),
            DestinationTranslatedPort = toint(destinationTranslatedPort),
            SourceTranslatedPort = toint(sourceTranslatedPort),
            DeviceTranslatedPort = toint(deviceTranslatedPort),
            SentBytes = tolong(out),
            ReceivedBytes = tolong(inbytes),
            Protocol = tostring(proto),
            SourceUserName = tostring(suser),
            SourceUserPrivileges = tostring(spriv),
            CommunicationDirection = tostring(deviceDirection),
            rulelabel = tostring(reason) ,
            DeviceVendor = tostring(DeviceVendor),
            DeviceProduct = tostring(DeviceProduct),
            Activity = tostring(act),
            Reason = tostring(reason)
    FWLOGKQLDATA
}

# locals {
#   local_web_declaration_stream      = jsondecode(file("${path.root}/json_data/web_log_schema.json"))
#   local_dns_declaration_stream      = jsondecode(file("${path.root}/json_data/dns_log_schema.json"))
#   local_firewall_declaration_stream = jsondecode(file("${path.root}/json_data/firewall_log_schema.json"))
# }

locals {
  local_web_stream_declaration = {
    "name" : "sourcetype",
    "type" : "String"
  }
}

