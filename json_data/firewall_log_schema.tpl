{
    "properties": {
        "schema": {
            "name": "${firewall_log_table_name}",
            "columns": [
                {
                    "name": "sourcetype",
                    "type": "String"
                },
                {
                    "name": "TimeGenerated",
                    "type": "DateTime"
                },
                {
                    "name": "act",
                    "type": "String"
                },
                {
                    "name": "suser",
                    "type": "String"
                },
                {
                    "name": "src",
                    "type": "String"
                },
                {
                    "name": "spt",
                    "type": "String"
                },
                {
                    "name": "dst",
                    "type": "String"
                },
                {
                    "name": "dpt",
                    "type": "String"
                },
                {
                    "name": "deviceTranslatedAddress",
                    "type": "String"
                },
                {
                    "name": "deviceTranslatedPort",
                    "type": "String"
                },
                {
                    "name": "destinationTranslatedAddress",
                    "type": "String"
                },
                {
                    "name": "destinationTranslatedPort",
                    "type": "String"
                },
                {
                    "name": "sourceTranslatedAddress",
                    "type": "String"
                },
                {
                    "name": "sourceTranslatedPort",
                    "type": "String"
                },
                {
                    "name": "proto",
                    "type": "String"
                },
                {
                    "name": "flexString2",
                    "type": "String"
                },
                {
                    "name": "flexString2Label",
                    "type": "String"
                },
                {
                    "name": "tunnelType",
                    "type": "String"
                },
                {
                    "name": "dnat",
                    "type": "String"
                },
                {
                    "name": "stateful",
                    "type": "String"
                },
                {
                    "name": "spriv",
                    "type": "String"
                },
                {
                    "name": "reason",
                    "type": "String"
                },
                {
                    "name": "inbytes",
                    "type": "String"
                },
                {
                    "name": "out",
                    "type": "String"
                },
                {
                    "name": "deviceDirection",
                    "type": "String"
                },
                {
                    "name": "cs1",
                    "type": "String"
                },
                {
                    "name": "cs1Label",
                    "type": "String"
                },
                {
                    "name": "cs2",
                    "type": "String"
                },
                {
                    "name": "cs2Label",
                    "type": "String"
                },
                {
                    "name": "cs3",
                    "type": "String"
                },
                {
                    "name": "cs3Label",
                    "type": "String"
                },
                {
                    "name": "cs4",
                    "type": "String"
                },
                {
                    "name": "cs4Label",
                    "type": "String"
                },
                {
                    "name": "cs5",
                    "type": "String"
                },
                {
                    "name": "cs5Label",
                    "type": "String"
                },
                {
                    "name": "cs6",
                    "type": "String"
                },
                {
                    "name": "cs6Label",
                    "type": "String"
                },
                {
                    "name": "cn1",
                    "type": "String"
                },
                {
                    "name": "cn1Label",
                    "type": "String"
                },
                {
                    "name": "cn2",
                    "type": "String"
                },
                {
                    "name": "cn2Label",
                    "type": "String"
                },
                {
                    "name": "flexString1",
                    "type": "String"
                },
                {
                    "name": "flexString1Label",
                    "type": "String"
                },
                {
                    "name": "cfp1Label",
                    "type": "String"
                },
                {
                    "name": "cfp1",
                    "type": "String"
                },
                {
                    "name": "DeviceVendor",
                    "type": "String"
                },
                {
                    "name": "DeviceProduct",
                    "type": "String"
                }
            ]
        },
        "retentionInDays": 90
    }
}
