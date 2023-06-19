################################################################################
# 1. Create Custom Table for Data Collection Rule
#
################################################################################
resource "azapi_resource" "custom_table_creation" {
  type                      = "Microsoft.OperationalInsights/workspaces/tables@2022-10-01"
  name                      = var.custom_table_name
  parent_id                 = var.parent_id
  schema_validation_enabled = false
  body                      = var.json_data
}
