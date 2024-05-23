variable "location" {
  description = "The Azure region to create things in."
  type        = string
}

variable "environment" {
  description = "Environment to deploy to."
  type        = string
}

variable "location_short" {
  description = "The Azure region short name."
  type        = string
}

variable "common_name" {
  description = "The commonName to use for the deploy"
  type        = string
}

variable "vnet_config" {
  description = "Address spaces used by virtual network."
  type = object({
    address_space = list(string)
    subnets = list(object({
      name              = string
      cidr              = string
      service_endpoints = list(string)
    }))
    dns_servers = list(string)
  })
}

variable "unique_suffix" {
  description = "Customer unique suffix."
  type        = string
}

variable "route_config" {
  description = "Route configuration. Not applied to AKS subnets"
  type = list(object({
    subnet_name = string # Short name for the subnet
    routes = list(object({
      name                   = string # Name of the route
      address_prefix         = string # Example: 192.168.0.0/24
      next_hop_type          = string # VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None
      next_hop_in_ip_address = string # Only set if next_hop_type is VirtualAppliance
    }))

  }))
  default = []
}

variable "peering_config" {
  description = "Network peering configuration"
  type = list(object({
    name                         = string
    remote_virtual_network_id    = string
    allow_forwarded_traffic      = bool
    use_remote_gateways          = bool
    allow_virtual_network_access = bool
  }))
  default = []
}

variable "subnet_private_endpoints" {
  description = "Enable private enpoint for specific subnet names"
  type        = map(bool)
  default     = {}
}
