resource "azurerm_storage_account" "storage_account" {
  name                     = "st${var.environment}${var.location_short}${var.common_name}${var.unique_suffix}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
