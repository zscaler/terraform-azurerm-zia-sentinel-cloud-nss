terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.54.0"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
  required_version = ">= 0.13.7, < 2.0.0"
}
