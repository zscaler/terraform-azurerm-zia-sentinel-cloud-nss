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

variable "environment" {
  type        = string
  description = "Customer defined environment tag. ie: Dev, QA, Prod, etc."
  default     = "Development"
}

variable "owner_tag" {
  type        = string
  description = "Customer defined owner tag value. ie: Org, Dept, username, etc."
  default     = "zscaler"
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
# Step 3. Azure Active Directory (AD) Application and Create a Client Secret
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################

variable "application_display_name" {
  type        = string
  description = ""
}

################################################################################
# Step 4. Sentinel Custom Table variables
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################

variable "firewall_log_custom_table" {
  type        = string
  description = ""
}

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
