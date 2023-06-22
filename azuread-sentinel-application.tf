data "azuread_client_config" "current" {}

resource "azuread_application" "this" {
  display_name = "${var.application_display_name}-${random_string.suffix.result}"
  owners       = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal" "this" {
  application_id               = azuread_application.this.application_id
  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]
}

resource "azuread_application_password" "this" {
  display_name          = "${var.application_display_name}-${random_string.suffix.result}"
  application_object_id = azuread_application.this.object_id
}

data "azurerm_role_definition" "metric_publisher" {
  name = "Monitoring Metrics Publisher"
}

resource "azurerm_role_assignment" "sentinel_app_role_assignment" {
  principal_id       = azuread_service_principal.this.object_id
  role_definition_id = data.azurerm_role_definition.metric_publisher.role_definition_id
  scope              = azurerm_monitor_data_collection_rule.this.id
}
