<a href="https://terraform.io">
    <img src="https://raw.githubusercontent.com/hashicorp/terraform-website/master/public/img/logo-text.svg" alt="Terraform logo" title="Terraform" height="40" width="200" />
</a>
<a href="https://www.zscaler.com/">
    <img src="https://www.zscaler.com/themes/custom/zscaler/logo.svg" alt="Zscaler logo" title="Zscaler" height="40" width="200" />
</a>

Zscaler Cloud NSS and Sentinel Deployment
===========================================================================================================

Support Disclaimer
-------
!> **Disclaimer:** This Terraform provider is community supported. Although this provider is supported by Zscaler employees, it is **NOT** supported by Zscaler support. Please open all enhancement requests and issues on [Github Issues](https://github.com/zscaler/terraform-provider-zpa/issues) for support.

## Description
This repository contains a purposefuly built Azure Sentinel Terraform module designed to enable the integration with Zscaler Internet Access (NSS Cloud).

This deployment template can be used for setting up your production network or for proof of concept (PoC) topologies and demos, if evaluating interoperability and integration.

The module contains all the necessary resources required to deploy Azure Sentinel, including Azure Sentinel workspaces, Log Analytics workspaces, Data Collection Endpoints, Data Collection Rules, and custom tables.

This template is designed to create individual custom tables for all Zscaler's supported log ingestion types: Web, DNS, and Firewall logs.

## Prerequisites
Our Deployment scripts are leveraging Terraform v1.4.6 that includes full binary and provider support for MacOS M1 chips, but any Terraform version 1.0.0 should be generally supported.

- provider registry.terraform.io/hashicorp/azurerm v3.60.x
- provider registry.terraform.io/hashicorp/azuread v2.39.x
- provider registry.terraform.io/hashicorp/azapi v1.7.0.x
- provider registry.terraform.io/hashicorp/random v3.3.x
- provider registry.terraform.io/hashicorp/local v2.2.x

### Azure Requirements
1. Azure Subscription Id
[link to Azure subscriptions](https://portal.azure.com/#blade/Microsoft_Azure_Billing/SubscriptionsBlade)
2. Have/Create a Service Principal. See: https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal). Then Collect:
   1. Application (client) ID
   2. Directory (tenant) ID
   3. Client Secret Value
3. Azure Region (e.g. westus2) where App Connector resources are to be deployed

## How to deploy
Provisioning template is available for customer use/reference to successfully deploy a fully operational Sentinel Workspace once the prerequisites have been completed. Please follow the instructions located in [examples](examples/full_deployment/README.md).

## Usage

```hcl
provider "azurerm" {
  features {}
}

module "zia_sentinel_cloud_nss" {
  source = "zscaler/zia-sentinel-cloud-nss/azurerm"
  resource_group_name   = "my-new-resource-group"
  arm_location          = "westus2"
  sentinel_sku          = "PerGB2018"
  retention_in_days     = 90
  web_log_config = {
    enabled    = true
    table_name = "table_1_web_CL"
  }

  firewall_log_config = {
    enabled    = true
    table_name = "table_2_firewall_CL"
  }

  dns_log_config = {
    enabled    = true
    table_name = "table_3_dns_CL"
  }
  dce_kind                 = "Windows"
  application_display_name = "sentinelzscaler"

  #bring-your-own Resource Group variables
  byo_rg      = true
  byo_rg_name = "my-existing-resources"
}

```

## Versioning

These modules follow recommended release tagging in [Semantic Versioning](http://semver.org/). You can find each new release,
along with the changelog, on the GitHub [Releases](https://github.com/zscaler/terraform-aws-cloud-connector-modules/releases) page.
