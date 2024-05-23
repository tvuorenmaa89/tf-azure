# Add datasource for resource group
data "azurerm_resource_group" "rg" {
  name = "rg-${var.environment}-${var.location_short}-${var.common_name}"
}

data "azurerm_resource_group" "rg_core" {
  name = "rg-${var.environment}-${var.location_short}-${var.core_config.common_name}"
}
