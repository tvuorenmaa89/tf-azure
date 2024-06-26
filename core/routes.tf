resource "azurerm_route_table" "this" {
  for_each = {
    for route in var.route_config :
    route.subnet_name => route
  }

  name                = "udr-${var.environment}-${var.location_short}-${each.value.subnet_name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_route" "this" {
  for_each = {
    for route in local.routes :
    route.name => route
  }

  name                   = each.value.route.name
  resource_group_name    = data.azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.this[each.value.subnet_name].name
  address_prefix         = each.value.route.address_prefix
  next_hop_type          = each.value.route.next_hop_type
  next_hop_in_ip_address = each.value.route.next_hop_in_ip_address
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each = {
    for route in local.routes :
    route.name => route
  }

  subnet_id      = azurerm_subnet.this[each.value.subnet_name].id
  route_table_id = azurerm_route_table.this[each.value.subnet_name].id
}
