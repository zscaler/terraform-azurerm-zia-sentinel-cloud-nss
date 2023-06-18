locals {
  dnslogs_kql = <<-DNSLOGKQLDATA
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
}

locals {
    weblogs = var.create_weblogs == true ? local.weblogs_kql : false
    dnslogs = var.create_dnslogs == false ? local.dnslogs_kql : true
    fwlogs  = var.create_fwlogs == false ? local.firewalllogs_kql : true
    create_all_logs = coalesce(var.create_all_logs, local.weblogs, local.dnslogs, local.fwlogs )
}