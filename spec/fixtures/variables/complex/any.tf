variable "subnets" {
  type = any
  # Example
  default = {
    "app" = {
      address_prefixes = ["10.0.0.0/24"]
      service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    }
    "db" = {
      address_prefixes = ["10.0.1.0/24"]
      enforce_private_link_endpoint_network_policies = false
    }
  }
}
