resource "azurerm_monitor_data_collection_endpoint" "this" {
  name                          = "${var.name_prefix}-dce-${var.resource_tag}"
  resource_group_name           = data.azurerm_resource_group.this.name
  location                      = var.arm_location
  kind                          = var.dce_kind
  public_network_access_enabled = true
  tags                          = var.global_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_monitor_data_collection_rule" "this" {
  name                        = "${var.name_prefix}-dcr-${var.resource_tag}"
  resource_group_name         = data.azurerm_resource_group.this.name
  location                    = var.arm_location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.this.id
  tags                        = var.global_tags

  destinations {
    log_analytics {
      name                  = replace(azurerm_log_analytics_workspace.this.name, "-", "")
      workspace_resource_id = azurerm_log_analytics_workspace.this.id
    }
  }

  dynamic "data_flow" {
    for_each = {
      for t in local.custom_tables :
      t.table_name => t
      if t.enabled
    }

    content {
      destinations = [
        replace(azurerm_log_analytics_workspace.this.name, "-", ""),
      ]
      output_stream = "Microsoft-CommonSecurityLog"
      streams = [
        "Custom-${data_flow.key}",
      ]
      transform_kql = data_flow.value.kql
    }
  }

  dynamic "stream_declaration" {
    for_each = {
      for t in local.custom_tables :
      t.table_name => t
      if t.enabled
    }

    content {
      stream_name = "Custom-${stream_declaration.key}"

      dynamic "column" {
        for_each = { for c in stream_declaration.value.schema.properties.schema.columns : c.name => c }

        content {
          name = column.key
          type = lower(column.value.type)
        }
      }
    }
  }

  depends_on = [
    azapi_resource.custom_tables
  ]
}
