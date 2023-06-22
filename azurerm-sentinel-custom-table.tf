resource "azapi_resource" "custom_tables" {
  for_each = {
    for t in local.custom_tables :
    t.table_name => t
    if t.enabled
  }

  type                      = "Microsoft.OperationalInsights/workspaces/tables@2022-10-01"
  name                      = each.key
  location                  = var.arm_location
  parent_id                 = azurerm_log_analytics_workspace.this.id
  schema_validation_enabled = false
  body                      = jsonencode(each.value.schema)
  tags                      = local.global_tags
}
