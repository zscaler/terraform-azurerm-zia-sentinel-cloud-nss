################################################################################
# Resource Group
################################################################################
# Create Resource Group or reference existing
resource "azurerm_resource_group" "rg" {
  count    = var.byo_rg == false ? 1 : 0
  name     = "${var.name_prefix}-rg-${var.resource_tag}"
  location = var.location

  tags = var.global_tags
}

data "azurerm_resource_group" "rg_selected" {
  name = var.byo_rg == false ? azurerm_resource_group.rg[0].name : var.byo_rg_name
}

resource "azurerm_log_analytics_workspace" "sentinel_workspace" {
  name                = "${var.name_prefix}-znss-${var.resource_tag}"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg_selected.name
  sku                 = var.sentinel_sku
  retention_in_days   = var.retention_in_days
}

resource "azurerm_log_analytics_solution" "la_opf_solution_sentinel" {
  solution_name         = "SecurityInsights"
  location              = var.location
  resource_group_name   = data.azurerm_resource_group.rg_selected.name
  workspace_resource_id = azurerm_log_analytics_workspace.sentinel_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.sentinel_workspace.name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
  tags = var.tags
}
