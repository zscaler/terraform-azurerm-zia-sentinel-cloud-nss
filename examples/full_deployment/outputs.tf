locals {
  data_collection_endpoints = [for k, v in module.zia_sentinel_cloud_nss.data_collection_endpoints : "${k} => ${v.endpoint_url}"]
  testbedconfig             = <<TB

1)  In the ZIA Admin Portal, Add a Cloud NSS Feed
    Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-add-feed

2) SIEM Type: Select "Azure Sentinel"
  2.1) OAuth 2.0 Authentication: Enabled by default. The toggle is not editable.

  2.2) Application (Client ID) - Required for Cloud NSS feed in the ZIA Admin Portal
      ${module.zia_sentinel_cloud_nss.application_id}

  2.3) Client Secret Value - Required for Cloud NSS feed in the ZIA Admin Portal
      ${nonsensitive(module.zia_sentinel_cloud_nss.azuread_application_password)}

3) Scope URL and Grant Type
  3.1 Scope: Enter the following URL: https://monitor.azure.com//.default
  3.2 Grant Type: Enter the following string: client_credentials

4) Authorization URL
  4.1 Enter the authorization URL: https://login.microsoftonline.com/${module.zia_sentinel_cloud_nss.tenant_id}/oauth2/v2.0/token

5) Log Ingestion API URL - Required for Cloud NSS feed in the ZIA Admin Portal. You can get the endpoints from this module's terraform output
  ${join("\n\n", local.data_collection_endpoints)}

8) HTTP Headers
  8.1) Key 1: Enter Content-Type
  8.2) Value 1: Enter application/json

9) Feed Output Type: Select JSON.
10) JSON Array Notation: Enable this setting.
11) Feed Escape Character: Enter "/,
TB
}

output "testbedconfig" {
  description = "Azure Testbed results"
  value       = local.testbedconfig
}

resource "local_file" "testbed" {
  content  = local.testbedconfig
  filename = "testbed.txt"
}

output "data_collection_endpoints" {
  value = local.data_collection_endpoints
}
