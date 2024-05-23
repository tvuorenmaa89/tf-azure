data "azurerm_key_vault" "kv" {
  name                = "kv-${var.environment}-${var.location_short}-${var.common_name}-${var.unique_suffix}"
  resource_group_name = "rg-${var.environment}-${var.location_short}-${var.core_config.common_name}"
}
