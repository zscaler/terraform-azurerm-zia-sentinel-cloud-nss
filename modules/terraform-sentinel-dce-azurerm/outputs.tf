output "data_collection_endpoint_id" {
  description = "The ID of the Data Collection Endpoint."
  value       = azurerm_monitor_data_collection_endpoint.dce_sentinel.id
}

output "logs_ingestion_endpoint" {
  description = "The endpoint used for ingesting logs, e.g., https://mydce-abcd.eastus-1.ingest.monitor.azure.com"
  value       = azurerm_monitor_data_collection_endpoint.dce_sentinel.logs_ingestion_endpoint
}
