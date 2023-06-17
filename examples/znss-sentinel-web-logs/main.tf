################################################################################
# Generate a unique random string for resource name assignment and key pair
################################################################################
resource "random_string" "suffix" {
  length  = 8
  upper   = false
  special = false
}

################################################################################
# Map default tags with values to be assigned to all tagged resources
################################################################################
locals {
  global_tags = {
    Owner       = var.owner_tag
    ManagedBy   = "terraform"
    Vendor      = "Zscaler"
    Environment = var.environment
  }
}

################################################################################
# Step 1. Create Log Analytics workspace
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-workspace-add-sentinel
################################################################################
module "sentinel_workspace" {
  source            = "../../modules/terraform-sentinel-workspace-azurerm"
  name_prefix       = var.name_prefix
  resource_tag      = random_string.suffix.result
  global_tags       = local.global_tags
  location          = var.arm_location
  sentinel_sku      = var.sentinel_sku
  retention_in_days = var.retention_in_days
}

########################################################################################
# Step 2.  Register an Azure Active Directory (AD) Application and Create a Client Secret
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-register-app-create-secret
########################################################################################
data "azuread_client_config" "current" {}

resource "azuread_application" "app_registration" {
  display_name = var.sentinel_app_registration
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "service_principal" {
  application_id               = azuread_application.app_registration.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "app_registration_value" {
  display_name          = var.application_display_name
  application_object_id = azuread_application.app_registration.object_id
}

################################################################################
# Step 3. Create Custom Table for Data Collection Rule
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-dce
################################################################################
module "table_creation" {
  source               = "../../modules/terraform-sentinel-table-endpoint"
  parent_id            = module.sentinel_workspace.azurerm_log_analytics_workspace
  endpoint_name        = "${var.name_prefix}-dce-${random_string.suffix.result}"
  endpoint_description = "${var.name_prefix}-dce-${random_string.suffix.result}"
  location             = var.arm_location
  resource_group_name  = module.sentinel_workspace.resource_group_name
  tags                 = local.global_tags
  custom_table_name    = var.web_log_custom_table
  json_data            = local_file.web_log_custom_table.content
  depends_on = [
    module.sentinel_workspace,
    local_file.web_log_custom_table
  ]
}

locals {
  web_log_schema = templatefile("${path.module}/data/web_log_schema.json", {
  web_log_table_name = var.web_log_custom_table
  })
}

resource "local_file" "web_log_custom_table" {
  content  = local.web_log_schema
  filename = "./data/web_log_schema.tpl"
}

################################################################################
# Step 4.1 Create a Sentinel Data Collection Rule
# Reference: https://help.zscaler.com/zia/zia-microsoft-azure-sentinel-integration-guide#zia-cloud-nss-step-create-table-dcr
################################################################################
resource "azurerm_monitor_data_collection_rule" "data_collection_rule" {
  data_collection_endpoint_id = module.table_creation.data_collection_endpoint_id
  location                    = var.arm_location
  name                        = var.collection_rule_name
  resource_group_name         = module.sentinel_workspace.resource_group_name
  tags                        = local.global_tags

  data_flow {
    destinations = [
      "${replace(module.sentinel_workspace.workspace_id, "-", "")}",
    ]
    # The Output Stream value should not be changed.
    # The Microsoft-CommonSecurityLog value is added to the outputStream so that
    # logs are sent to a Common Event Format (CEF) table instead of a custom log (CL) table
    output_stream = "Microsoft-CommonSecurityLog"
    streams = [
      "Custom-${module.table_creation.table_creation_name}_CL",
    ]
    transform_kql = local_file.web_log_transform_kql.content
  }
  destinations {
    log_analytics {
      name                  = "${replace(module.sentinel_workspace.workspace_id, "-", "")}"
      workspace_resource_id = module.sentinel_workspace.azurerm_log_analytics_workspace
    }
  }

  stream_declaration {
    stream_name = "Custom-${module.table_creation.table_creation_name}_CL"

    column {
      name = "sourcetype"
      type = "string"
    }
    column {
      name = "TimeGenerated"
      type = "datetime"
    }
    column {
      name = "act"
      type = "string"
    }
    column {
      name = "reason"
      type = "string"
    }
    column {
      name = "app"
      type = "string"
    }
    column {
      name = "dhost"
      type = "string"
    }
    column {
      name = "dst"
      type = "string"
    }
    column {
      name = "src"
      type = "string"
    }
    column {
      name = "sourceTranslatedAddress"
      type = "string"
    }
    column {
      name = "in"
      type = "string"
    }
    column {
      name = "out"
      type = "string"
    }
    column {
      name = "request"
      type = "string"
    }
    column {
      name = "requestContext"
      type = "string"
    }
    column {
      name = "outcome"
      type = "string"
    }
    column {
      name = "requestClientApplication"
      type = "string"
    }
    column {
      name = "requestMethod"
      type = "string"
    }
    column {
      name = "suser"
      type = "string"
    }
    column {
      name = "spriv"
      type = "string"
    }
    column {
      name = "externalId"
      type = "string"
    }
    column {
      name = "fileType"
      type = "string"
    }
    column {
      name = "destinationServiceName"
      type = "string"
    }
    column {
      name = "cat"
      type = "string"
    }
    column {
      name = "deviceDirection"
      type = "string"
    }
    column {
      name = "cn1"
      type = "string"
    }
    column {
      name = "cn1Label"
      type = "string"
    }
    column {
      name = "cs1"
      type = "string"
    }
    column {
      name = "cs1Label"
      type = "string"
    }
    column {
      name = "cs2"
      type = "string"
    }
    column {
      name = "cs2Label"
      type = "string"
    }
    column {
      name = "cs3"
      type = "string"
    }
    column {
      name = "cs3Label"
      type = "string"
    }
    column {
      name = "cs4"
      type = "string"
    }
    column {
      name = "cs4Label"
      type = "string"
    }
    column {
      name = "cs5"
      type = "string"
    }
    column {
      name = "cs5Label"
      type = "string"
    }
    column {
      name = "cs6"
      type = "string"
    }
    column {
      name = "cs6Label"
      type = "string"
    }
    column {
      name = "rulelabel"
      type = "string"
    }
    column {
      name = "ruletype"
      type = "string"
    }
    column {
      name = "urlclass"
      type = "string"
    }
    column {
      name = "DeviceVendor"
      type = "string"
    }
    column {
      name = "DeviceProduct"
      type = "string"
    }
    column {
      name = "devicemodel"
      type = "string"
    }
    column {
      name = "flexString1"
      type = "string"
    }
    column {
      name = "flexString1Label"
      type = "string"
    }
    column {
      name = "flexString2"
      type = "string"
    }
    column {
      name = "flexString2Label"
      type = "string"
    }
  }
  depends_on = [
    module.table_creation,
    module.sentinel_workspace
  ]
}

locals {
  web_log_kql = templatefile("${path.module}/transform_data/web_logs.kql", {
  })
}

resource "local_file" "web_log_transform_kql" {
  content  = local.web_log_kql
  filename = "./transform_data/web_logs.tpl"
}