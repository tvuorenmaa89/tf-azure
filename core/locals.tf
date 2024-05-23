locals {
  peerings = [
    for peering_config in var.peering_config : {
      name           = "${var.environment}-${var.location_short}-${var.common_name}-${peering_config.name}"
      peering_config = peering_config
    }
  ]
  routes = flatten([])
}
