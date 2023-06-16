output "resource_group_name" {
  description = "Azure Resource Group Name"
  value       = data.azurerm_resource_group.rg_selected.name
}


output "azurerm_log_analytics_workspace" {
  description = "Azure Resource Group Name"
  value       = azurerm_log_analytics_workspace.sentinel_workspace.id
}

output "workspace_id" {
  description = "Sentinel Workspace ID"
  value       = azurerm_log_analytics_workspace.sentinel_workspace.workspace_id
}