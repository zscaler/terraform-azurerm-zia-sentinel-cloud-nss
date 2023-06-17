variable "arm_location" {
  type        = string
  description = "The Azure Region where resources are to be deployed"
  default     = "canadacentral"
}

variable "name_prefix" {
  type        = string
  description = "The name prefix for all your resources"
  default     = "zsdemo"
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

variable "sentinel_app_registration" {
  type        = string
  description = ""
}

variable "application_display_name" {
  type        = string
  description = ""
}

variable "collection_rule_name" {
  type        = string
  description = ""
}
variable "web_log_custom_table" {
  type        = string
  description = ""
}

variable "create_all_logs" {
  type        = bool
  description = "Specifies whether the SG module should create 1:1 security groups per instance or 1 security group for all instances"
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