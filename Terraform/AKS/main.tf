resource "azurerm_resource_group" "aksrg" {
    location = var.env.location
    name = "myvnet"
}

