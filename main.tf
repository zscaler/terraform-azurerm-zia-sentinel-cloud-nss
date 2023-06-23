
data "azurerm_resource_group" "this" {
  name = var.byo_rg == false ? azurerm_resource_group.this[0].name : var.byo_rg_name
}

resource "azurerm_resource_group" "this" {
  count    = var.byo_rg == false ? 1 : 0
  name     = "${var.name_prefix}-rg-${var.resource_tag}"
  location = var.arm_location

  tags = var.global_tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.name_prefix}-znss-${var.resource_tag}"
  location            = var.arm_location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = var.sentinel_sku
  retention_in_days   = var.retention_in_days

  tags = var.global_tags
}

resource "azurerm_log_analytics_solution" "this" {
  solution_name         = "SecurityInsights"
  location              = var.arm_location
  resource_group_name   = data.azurerm_resource_group.this.name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }

  tags = var.global_tags
}
