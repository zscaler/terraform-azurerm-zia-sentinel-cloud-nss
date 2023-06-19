terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.60.0"
    }
  }
  required_version = ">= 0.13.7, < 2.0.0"
}
