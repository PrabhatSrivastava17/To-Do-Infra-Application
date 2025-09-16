resource "azurerm_network_interface" "nic" {
  name                = "devops-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

variable "rg_name" {
  description = "The name of the resource group in which to create the network interface."
  type        = string
}
variable "location" {
  description = "The Azure region where the network interface will be created."
  type        = string
}