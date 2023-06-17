## 1. Specify the Azure location where the Sentinel Workspace must be created.
##

arm_location      = "canadacentral"

## 2. Specify the Azure Sentinel SKU to deploy.
##

sentinel_sku      = "PerGB2018" # This is default Sentinel SKU for all deployments
# sentinel_sku      = "Free"
# sentinel_sku      = "PerNode"
# sentinel_sku      = "Premium"
# sentinel_sku      = "Standard"
# sentinel_sku      = "Standalone"
# sentinel_sku      = "Unlimited"
# sentinel_sku      = "CapacityReservation"

## 3. Specify the Azure Sentinel Retention Period.
##

# retention_in_days = 30
# retention_in_days = 60
retention_in_days = 90 # Default retetion period
# retention_in_days = 120
# retention_in_days = 180
# retention_in_days = 270
# retention_in_days = 365 # 1 years
# retention_in_days = 547 # 1.5 years
# retention_in_days = 730 # 2 years


## 4. Specify the name of the Azure sentinel application.
##
sentinel_app_registration = "sentinelZscaler"
application_display_name  = "sentinelZscaler"

## 5. Specify a name for the Azure Sentinel Collection Rule.
##
collection_rule_name        = "test-1-DCR"

## 6. Specify a name for the Azure Sentinel Custom table.
##
firewall_log_custom_table   = "table_1_firewall_CL"