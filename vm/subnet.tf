data "azurerm_subnet" "subnet_1" {
  name                 = "snet-${var.environment}-${var.location_short}-${var.core_config.subnet_name_1}-01"
  virtual_network_name = "vnet-${var.environment}-${var.location_short}-${var.core_config.common_name}-01"
  resource_group_name  = "rg-${var.environment}-${var.location_short}-${var.core_config.common_name}"
}

data "azurerm_subnet" "subnet_2" {
  name                 = "snet-${var.environment}-${var.location_short}-${var.core_config.subnet_name_2}-01"
  virtual_network_name = "vnet-${var.environment}-${var.location_short}-${var.core_config.common_name}-01"
  resource_group_name  = "rg-${var.environment}-${var.location_short}-${var.core_config.common_name}"
}

data "azurerm_subnet" "subnet_3" {
  name                 = "snet-${var.environment}-${var.location_short}-${var.core_config.subnet_name_3}-01"
  virtual_network_name = "vnet-${var.environment}-${var.location_short}-${var.core_config.common_name}-01"
  resource_group_name  = "rg-${var.environment}-${var.location_short}-${var.core_config.common_name}"
}
