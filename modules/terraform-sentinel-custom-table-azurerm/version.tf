terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.7.0"
    }
  }
  required_version = ">= 0.13.7, < 2.0.0"
}
