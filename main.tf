provider "azurerm" {
  
}

resource "azurerm_resource_group" "RG" {
  name = "TestRG"
  location = "East US"
}


resource "azurerm_virtual_network" "Vnet" {
  name = "MyVnet"
  resource_group_name = azurerm_resource_group.RG.name
  location = azurerm_resource_group.RG.location
  address_space = [ "10.0.0.1/16" ]
}

resource "azurerm_subnet" "subnet" {
  name = "TestSubnet"
  resource_group_name = azurerm_resource_group.RG.name
  virtual_network_name = azurerm_virtual_network.Vnet.name
  address_prefixes = [ "10.0.0.2/24" ]
}

resource "azurerm_public_ip" "pip" {
  name = "PIP"
  resource_group_name = azurerm_resource_group.RG.name
  location = azurerm_resource_group.RG.location
  allocation_method = "Dynamic"
}

resource "azurerm_network_interface" "Nic" {
  name = "NIC"
  location = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  ip_configuration {
    name = "internal"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}












resource "azurerm_virtual_machine" "VM" {
  name = "Vm1"
  location = azurerm_resource_group.RG
  resource_group_name = azurerm_resource_group.RG
  vm_size = 
  storage_data_disk {
    
  }
}