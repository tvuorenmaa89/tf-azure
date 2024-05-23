resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}-${var.location_short}-${var.common_name}-01"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = var.vnet_config.address_space
  dns_servers         = var.vnet_config.dns_servers
}

resource "azurerm_virtual_network_peering" "this" {
  for_each = {
    for peering_config in local.peerings :
    peering_config.name => peering_config
  }

  name                         = "peering-${each.value.name}"
  resource_group_name          = data.azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = each.value.peering_config.remote_virtual_network_id
  allow_forwarded_traffic      = each.value.peering_config.allow_forwarded_traffic
  use_remote_gateways          = each.value.peering_config.use_remote_gateways
  allow_virtual_network_access = each.value.peering_config.allow_virtual_network_access
}
