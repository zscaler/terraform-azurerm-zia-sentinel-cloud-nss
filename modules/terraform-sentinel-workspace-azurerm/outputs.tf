output "resource_group_name" {
  description = "Azure Resource Group Name"
  value       = data.azurerm_resource_group.rg_selected.name
}


output "azurerm_log_analytics_workspace" {
  description = "The Log Analytics Workspace ID."
  value       = azurerm_log_analytics_workspace.sentinel_workspace.id
}

output "workspace_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.sentinel_workspace.workspace_id
}