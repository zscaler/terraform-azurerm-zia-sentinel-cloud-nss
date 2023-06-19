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
# Step 3. Sentinel Custom Table variables
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################

variable "web_log_custom_table" {
  type        = string
  description = "The name of the web log custom table"
}

variable "firewall_log_custom_table" {
  type        = string
  description = "The name of the firewall log custom table"
}

variable "dns_log_custom_table" {
  type        = string
  description = "The name of the dns log custom table"
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
/*
variable "create_all_logs" {
  type        = bool
  description = "Specifies tables for all log types should be created"
  default     = false
}

variable "create_weblogs" {
  type        = bool
  description = "Specifies whether the SG module should create 1:1 security groups per instance or 1 security group for all instances"
  default     = false
}

variable "create_dnslogs" {
  type        = bool
  description = "Specifies whether the SG module should create 1:1 security groups per instance or 1 security group for all instances"
  default     = false
}

variable "create_fwlogs" {
  type        = bool
  description = "Specifies whether the SG module should create 1:1 security groups per instance or 1 security group for all instances"
  default     = false
}
*/

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
