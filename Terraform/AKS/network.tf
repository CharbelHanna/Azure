resource "azurerm_virtual_network" "vnet" {
  location            = var.env.location
  name                = var.vnet.name
  address_space       = var.vnet.address_spaces
  resource_group_name = "komo-core-rg"
}
