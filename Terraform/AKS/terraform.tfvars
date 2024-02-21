env = {
  location = "francecentral"
}

vnet = {
  "address_spaces" = [
    "10.10.0.0/16"
  ]
  "subnet_list" = {
    "GatewaySubnet" = 1
    "Aks-Subnet"    = 2


  }
}

