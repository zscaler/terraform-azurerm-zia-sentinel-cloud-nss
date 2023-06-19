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

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource. This will be inherited by all child resources."
}
