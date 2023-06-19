################################################################################
# 1. Create/reference all network infrastructure resource dependencies for all
#    child modules (Resource Group, VNet, Subnets, NAT Gateway, Route Tables)
################################################################################
resource "azurerm_monitor_data_collection_endpoint" "dce_sentinel" {
  name                          = var.endpoint_name
  description                   = var.endpoint_description
  location                      = var.location
  resource_group_name           = var.resource_group_name
  kind                          = var.dce_kind
  public_network_access_enabled = true
  tags                          = var.tags

  lifecycle {
    create_before_destroy = true
  }
}
