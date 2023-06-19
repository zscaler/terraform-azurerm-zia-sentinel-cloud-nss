locals {
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

locals {
    weblogs = var.create_weblogs == true ? local.weblogs_kql : false
    dnslogs = var.create_dnslogs == false ? local.dnslogs_kql : true
    fwlogs  = var.create_fwlogs == false ? local.firewalllogs_kql : true
    create_all_logs = coalesce(var.create_all_logs, local.weblogs, local.dnslogs, local.fwlogs )
}