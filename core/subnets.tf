resource "azurerm_subnet" "this" {
  for_each = {
    for subnet in var.vnet_config.subnets :
    subnet.name => subnet
  }
  name                                           = "snet-${var.environment}-${var.location_short}-${each.value.name}-01"
  resource_group_name                            = data.azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [each.value.cidr]
  service_endpoints                              = each.value.service_endpoints
  enforce_private_link_endpoint_network_policies = try(var.subnet_private_endpoints[each.value.name], false)
}
