################################################################################
# 1. Create Custom Table for Data Collection Rule
#
################################################################################
resource "azapi_resource" "table_creation" {
  type                      = "Microsoft.OperationalInsights/workspaces/tables@2022-10-01"
  name                      = var.custom_table_name
  parent_id                 = var.parent_id
  schema_validation_enabled = false
  body                      = var.json_data
}

################################################################################
# 2. Create/reference all network infrastructure resource dependencies for all
#    child modules (Resource Group, VNet, Subnets, NAT Gateway, Route Tables)
################################################################################
resource "azurerm_monitor_data_collection_endpoint" "dce_sentinel" {
  name                          = var.endpoint_name
  description                   = var.endpoint_description
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = "Windows"
  public_network_access_enabled = true
  tags                          = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

