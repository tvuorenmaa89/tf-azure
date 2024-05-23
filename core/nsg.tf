resource "azurerm_network_security_group" "this" {
  for_each            = { for subnet in var.vnet_config.subnets : subnet.name => subnet }
  name                = "nsg-${var.environment}-${var.location_short}-${each.value.name}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each                  = { for subnet in var.vnet_config.subnets : subnet.name => subnet }
  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}
