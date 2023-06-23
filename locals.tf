locals {
  ### Web log formatting
  web_log_schema     = jsondecode(file("${path.module}/config/schema/web_log.json"))
  web_log_table_name = var.web_log_config.enabled ? endswith(var.web_log_config.table_name, "_CL") ? var.web_log_config.table_name : "${var.web_log_config.table_name}_CL" : var.web_log_config.table_name
  web_log = merge(var.web_log_config, {
    schema = var.web_log_config.enabled ? {
      properties = {
        retentionInDays = try(local.web_log_schema.properties.schema.retentionInDays, 90)
        schema = {
          name    = local.web_log_table_name
          columns = try(local.web_log_schema.properties.schema.columns, [])
        }
      }
    } : {}
    kql        = file("${path.module}/config/kql/web_log.kql")
    table_name = local.web_log_table_name
  })

  #### DNS log formatting
  dns_log_schema     = jsondecode(file("${path.module}/config/schema/dns_log.json"))
  dns_log_table_name = var.dns_log_config.enabled ? endswith(var.dns_log_config.table_name, "_CL") ? var.dns_log_config.table_name : "${var.dns_log_config.table_name}_CL" : var.dns_log_config.table_name
  dns_log = merge(var.dns_log_config, {
    schema = var.dns_log_config.enabled ? {
      properties = {
        retentionInDays = try(local.dns_log_schema.properties.schema.retentionInDays, 90)
        schema = {
          name    = local.dns_log_table_name
          columns = try(local.dns_log_schema.properties.schema.columns, [])
        }
      }
    } : {}
    kql        = file("${path.module}/config/kql/dns_log.kql")
    table_name = local.dns_log_table_name
  })

  #### Firewall log formatting
  firewall_log_schema     = jsondecode(file("${path.module}/config/schema/firewall_log.json"))
  firewall_log_table_name = var.firewall_log_config.enabled ? endswith(var.firewall_log_config.table_name, "_CL") ? var.firewall_log_config.table_name : "${var.firewall_log_config.table_name}_CL" : var.firewall_log_config.table_name
  firewall_log = merge(var.firewall_log_config, {
    schema = var.firewall_log_config.enabled ? {
      properties = {
        retentionInDays = try(local.firewall_log_schema.properties.schema.retentionInDays, 90)
        schema = {
          name    = local.firewall_log_table_name
          columns = try(local.firewall_log_schema.properties.schema.columns, [])
        }
      }
    } : {}
    kql        = file("${path.module}/config/kql/firewall_log.kql")
    table_name = local.firewall_log_table_name
  })

  custom_tables = [
    local.web_log,
    local.dns_log,
    local.firewall_log
  ]
}
