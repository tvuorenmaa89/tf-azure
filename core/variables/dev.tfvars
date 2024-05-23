environment    = "dev"
location       = "swedencentral"
location_short = "sc"

vnet_config = {
  address_space = ["10.0.0.0/16"]
  subnets = [
    {
      name              = "test1"
      cidr              = "10.0.0.0/24"
      service_endpoints = []
    },
    {
      name              = "test2"
      cidr              = "10.0.1.0/24"
      service_endpoints = []
    },
    {
      name              = "test3"
      cidr              = "10.0.2.0/24"
      service_endpoints = []
    },
  ]
  dns_servers = []
}

subnet_private_endpoints = {}

route_config = []

peering_config = []
