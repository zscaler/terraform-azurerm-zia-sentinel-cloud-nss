################################################################################
# Map default tags with values to be assigned to all tagged resources
################################################################################
locals {
  global_tags = merge({
    Owner       = var.owner_tag
    ManagedBy   = "terraform"
    Vendor      = "Zscaler"
    Environment = var.environment
  }, var.additional_tags)
}

################################################################################
# Generate a unique random string for resource name assignment and key pair
################################################################################
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

data "azurerm_resource_group" "this" {
  name = var.byo_rg == false ? azurerm_resource_group.this[0].name : var.byo_rg_name
}

resource "azurerm_resource_group" "this" {
  count    = var.byo_rg == false ? 1 : 0
  name     = "${var.name_prefix}-rg-${random_string.suffix.result}"
  location = var.arm_location

  tags = local.global_tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${var.name_prefix}-znss-${random_string.suffix.result}"
  location            = var.arm_location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = var.sentinel_sku
  retention_in_days   = var.retention_in_days

  tags = local.global_tags
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

  tags = local.global_tags
}
