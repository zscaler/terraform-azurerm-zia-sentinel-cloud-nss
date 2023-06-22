locals {
  ### Web log formatting
  web_log_schema = jsondecode(file("${path.module}/config/schema/web_log.json"))
  web_log = merge(var.web_log_config, {
    schema = var.web_log_config.enabled ? {
      properties = {
        retentionInDays = try(local.web_log_schema.properties.schema.retentionInDays, 90)
        schema = {
          name    = var.web_log_config.table_name
          columns = try(local.web_log_schema.properties.schema.columns, [])
        }
      }
    } : {}
    kql = file("${path.module}/config/kql/web_log.kql")
  })

  #### DNS log formatting
  dns_log_schema = jsondecode(file("${path.module}/config/schema/dns_log.json"))
  dns_log = merge(var.dns_log_config, {
    schema = var.dns_log_config.enabled ? {
      properties = {
        retentionInDays = try(local.dns_log_schema.properties.schema.retentionInDays, 90)
        schema = {
          name    = var.dns_log_config.table_name
          columns = try(local.dns_log_schema.properties.schema.columns, [])
        }
      }
    } : {}
    kql = file("${path.module}/config/kql/dns_log.kql")
  })

  #### Firewall log formatting
  firewall_log_schema = jsondecode(file("${path.module}/config/schema/firewall_log.json"))
  firewall_log = merge(var.firewall_log_config, {
    schema = var.firewall_log_config.enabled ? {
      properties = {
        retentionInDays = try(local.firewall_log_schema.properties.schema.retentionInDays, 90)
        schema = {
          name    = var.firewall_log_config.table_name
          columns = try(local.firewall_log_schema.properties.schema.columns, [])
        }
      }
    } : {}
    kql = file("${path.module}/config/kql/firewall_log.kql")
  })

  custom_tables = [
    local.web_log,
    local.dns_log,
    local.firewall_log
  ]
}
