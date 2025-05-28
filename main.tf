provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "RG" {
  name = "${var.prefix}-resource"
  location = var.location
}


resource "azurerm_virtual_network" "Vnet" {
  name = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.RG.name
  location = var.location
  address_space = [ "10.0.0.1/16" ]
}

resource "azurerm_subnet" "subnet" {
  name = "${var.prefix}-subnet"
  resource_group_name = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes = [ "10.0.0.2/24" ]
}

resource "azurerm_public_ip" "pip" {
  name = "${var.prefix}-pip"
  resource_group_name = azurerm_resource_group.RG.name
  location = var.location
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "Nic" {
  name = "${var.prefix}-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.RG.name
  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}












