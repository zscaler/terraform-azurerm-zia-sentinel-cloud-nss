output "data_collection_endpoint_id" {
  value = azurerm_monitor_data_collection_endpoint.dce_sentinel.id
}

output "table_creation_name" {
  value = azapi_resource.table_creation.name
}

output "logs_ingestion_endpoint" {
  value = azurerm_monitor_data_collection_endpoint.dce_sentinel.logs_ingestion_endpoint
}