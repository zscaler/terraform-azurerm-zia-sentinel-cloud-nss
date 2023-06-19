variable "location" {
  type        = string
  description = "The location of the resource. This will be inherited by all child resources."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resource. This will be inherited by all child resources."
}

variable "endpoint_name" {
  type        = string
  description = "The name of the data collection endpoint."
}

variable "endpoint_description" {
  type        = string
  description = "The description of the data collection endpoint."
}

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

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource. This will be inherited by all child resources."
}
