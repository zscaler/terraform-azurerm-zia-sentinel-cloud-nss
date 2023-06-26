################################################################################
# Step 1. Common variables across all resources
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################
variable "name_prefix" {
  type        = string
  description = "The name prefix for all your resources"
  default     = "zsdemo"
}

variable "arm_location" {
  type        = string
  description = "The Azure Region where resources are to be deployed"
  default     = "canadacentral"
}

variable "resource_tag" {
  type        = string
  description = "A tag to associate to all the network module resources"
  default     = null
}

variable "global_tags" {
  type        = map(string)
  description = "Populate any custom user defined tags from a map"
  default     = {}
}

################################################################################
# Step 2. Sentinel Workspace variables
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################
variable "sentinel_sku" {
  type        = string
  description = "Specifies the SKU of the Log Analytics Workspace"
  default     = "PerGB2018"
  validation {
    condition = (
      var.sentinel_sku == "Free" ||
      var.sentinel_sku == "PerGB2018" ||
      var.sentinel_sku == "PerNode" ||
      var.sentinel_sku == "Premium" ||
      var.sentinel_sku == "Standard" ||
      var.sentinel_sku == "Standalone" ||
      var.sentinel_sku == "Unlimited" ||
      var.sentinel_sku == "CapacityReservation"
    )
    error_message = "Input sentinel_sku must be set to an approved SKU."
  }
}

variable "retention_in_days" {
  description = "The workspace data retention in days. Possible values are either 7 (Free Tier only) or range between 30 and 730."
  type        = number
  default     = 90

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730 && floor(var.retention_in_days) == var.retention_in_days
    error_message = "Input value for retention_in_days must be between 30-730"
  }
}

################################################################################
# Step 3. Sentinel Custom Table variables
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################

variable "web_log_config" {
  type        = object({ enabled : bool, table_name : string })
  description = "The web logs config"

  default = {
    enabled    = false
    table_name = ""
  }

  validation {
    condition     = (var.web_log_config.enabled && length(var.web_log_config.table_name) > 0) || (!var.web_log_config.enabled)
    error_message = "Field 'table_name' must not be empty when when 'enabled' is set 'true'"
  }
}

variable "firewall_log_config" {
  type        = object({ enabled : bool, table_name : string })
  description = "The firewall log config"

  default = {
    enabled    = false
    table_name = ""
  }

  validation {
    condition     = (var.firewall_log_config.enabled && length(var.firewall_log_config.table_name) > 0) || (!var.firewall_log_config.enabled)
    error_message = "Field 'table_name' must not be empty when when 'enabled' is set 'true'"
  }
}

variable "dns_log_config" {
  type        = object({ enabled : bool, table_name : string })
  description = "The dns log config"

  default = {
    enabled    = false
    table_name = ""
  }

  validation {
    condition     = (var.dns_log_config.enabled && length(var.dns_log_config.table_name) > 0) || (!var.dns_log_config.enabled)
    error_message = "Field 'table_name' must not be empty when when 'enabled' is set 'true'"
  }
}

################################################################################
# Step 4. Data Collection Endpoint Kind
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################

variable "dce_kind" {
  type        = string
  description = "The kind of the Data Collection Endpoint. Possible values are Linux and Windows"
  default     = "Windows"
  validation {
    condition = (
      var.dce_kind == "Windows" ||
      var.dce_kind == "Linux"
    )
    error_message = "Input data collection endpoint dce_kind must be set to Windows or Linux."
  }
}

################################################################################
# Step 5. Azure Active Directory (AD) Application and Create a Client Secret
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################

variable "application_display_name" {
  type        = string
  description = "The display name for the application."
}

################################################################################
# Step 6. Set desired API Version. Default value is: "api-version=2021-11-01-preview"
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################
# variable "api_version" {
#   type        = string
#   description = "The name prefix for all your resources"
#   default     = "api-version=2021-11-01-preview"
# }

################################################################################
# BYO (Bring-your-own) variables list
################################################################################
variable "byo_rg" {
  type        = bool
  description = "Bring your own Azure Resource Group. If false, a new resource group will be created automatically"
  default     = false
}

variable "byo_rg_name" {
  type        = string
  description = "User provided existing Azure Resource Group name. This must be populated if byo_rg variable is true"
  default     = ""
}
