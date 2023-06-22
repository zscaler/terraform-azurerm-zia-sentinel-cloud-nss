module "zia_sentinel_cloud_nss" {
  source = "../../"

  arm_location      = var.arm_location
  sentinel_sku      = var.sentinel_sku # This is default Sentinel SKU for all deployments
  retention_in_days = 90               # Default retetion period

  #bring-your-own Resource Group variables
  byo_rg      = var.byo_rg
  byo_rg_name = var.byo_rg_name
  web_log_config = {
    enabled    = true
    table_name = var.web_log_config.table_name
  }

  firewall_log_config = {
    enabled    = true
    table_name = var.firewall_log_config.table_name
  }

  dns_log_config = {
    enabled    = true
    table_name = var.dns_log_config.table_name
  }

  dce_kind                 = var.dce_kind
  application_display_name = var.application_display_name
}
