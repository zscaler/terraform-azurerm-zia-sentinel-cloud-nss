variable "parent_id" {
  type = string
  description = "The ID of the parent resource. In the case of a root resource, this will be the workspace ID."
}
variable "location" {
  type = string
  description = "The location of the resource. This will be inherited by all child resources."
}
variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the resource. This will be inherited by all child resources."
}

variable "tags" {
  type = map
  description = "A mapping of tags to assign to the resource. This will be inherited by all child resources."
}

variable "json_data" {
  type = string
  description = "The JSON data to use for the data collection endpoint."
}
variable "custom_table_name" {
  type = string
  description = "The name of the custom table to create."
}

variable "create_web_log_custom_table" {
  description = ""
  default     = true
  type        = bool
}