output "table_name" {
  description = "Name of the custom sentinel table"
  value       = azapi_resource.custom_table_creation.name
}
