locals {

  testbedconfig = <<TB

1) Resource Group:
${module.sentinel_workspace.resource_group_name}

2) Sentinel Workspace ID
"${replace(module.sentinel_workspace.workspace_id, "-", "")}

3) Sentinel Custom Table name
"${module.table_creation.table_creation_name}"

4) Log Ingestion URI - Required for Cloud NSS feed in the ZIA Admin Portal
"${module.table_creation.logs_ingestion_endpoint}"

5) Application (Client) ID - Required for Cloud NSS feed in the ZIA Admin Portal
"${azuread_service_principal.service_principal.application_id}"

6) Directory (Tenant) ID - Required for Cloud NSS feed in the ZIA Admin Portal
"${azuread_service_principal.service_principal.application_tenant_id}"

7) Client Secret Value - Required for Cloud NSS feed in the ZIA Admin Portal
"${nonsensitive(azuread_application_password.app_registration_value.value)}"

8) Data Collection Rule Resource ID - Required for Cloud NSS feed in the ZIA Admin Portal
"${azurerm_monitor_data_collection_rule.data_collection_rule.id}"

9) Data Collection Rule Immutable ID - Required for Cloud NSS feed in the ZIA Admin Portal
"${azurerm_monitor_data_collection_rule.data_collection_rule.immutable_id}"
TB
}

output "testbedconfig" {
  description = "Azure Testbed results"
  value       = local.testbedconfig
}

resource "local_file" "testbed" {
  content  = local.testbedconfig
  filename = "./testbed.txt"
}