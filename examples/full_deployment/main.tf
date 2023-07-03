###############################################################
# Generate a unique random string for resource name assignment
###############################################################
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}


################################################################################
# Map default tags with values to be assigned to all tagged resources
################################################################################
locals {
  global_tags = {
    Owner       = var.owner_tag
    ManagedBy   = "terraform"
    Vendor      = "Zscaler"
    Environment = var.environment
  }
}

module "zia_sentinel_cloud_nss" {
  source            = "../../"
  name_prefix       = var.name_prefix
  arm_location      = var.arm_location
  sentinel_sku      = var.sentinel_sku
  retention_in_days = var.retention_in_days

  #bring-your-own Resource Group variables
  byo_rg      = var.byo_rg
  byo_rg_name = var.byo_rg_name

  web_log_config      = var.web_log_config
  firewall_log_config = var.firewall_log_config
  dns_log_config      = var.dns_log_config

  api_version = var.api_version

  dce_kind                 = var.dce_kind
  application_display_name = var.application_display_name

  resource_tag = random_string.suffix.result
  global_tags  = local.global_tags
}
