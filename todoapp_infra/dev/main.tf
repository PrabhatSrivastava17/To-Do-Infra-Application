module "resource_group" {
  source                  = "../../modules/azurerm_resource_group"
  resource_group_name     = "dev-rg-todoapp"
  resource_group_location = "centralindia"
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"

  virtual_network_name     = "dev-vnet-todoapp"
  virtual_network_location = "centralindia"
  resource_group_name      = "dev-rg-todoapp"
  address_space            = ["10.0.0.0/16"]
}
    
module "frontend_subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/azurerm_subnet"

  resource_group_name  = "dev-rg-todoapp"
  virtual_network_name = "dev-vnet-todoapp"
  subnet_name          = "dev-frontend-subnet"
  address_prefixes     = ["10.0.1.0/24"]
}

module "chinki_vm" {
  depends_on = [module.frontend_subnet, module.virtual_network]
  source     = "../../modules/azurerm_virtual_machine"

  resource_group_name  = "dev-rg-todoapp"
  location             = "centralindia"
  vm_name              = "chinki-vm"
  vm_size              = "Standard_B1s"
  admin_username       = "devopsadmin"
  admin_password       = "Admin@1234567"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "dev-nic-chinki"
  frontend_ip_name     = "dev-pip-todoapp-lb"
  vnet_name            = "dev-vnet-todoapp"
  frontend_subnet_name = "dev-frontend-subnet"
  nsg_name             = "chinki-nsg"
}

module "pinki_vm" {
  depends_on = [module.frontend_subnet, module.virtual_network]
  source     = "../../modules/azurerm_virtual_machine"

  resource_group_name  = "dev-rg-todoapp"
  location             = "centralindia"
  vm_name              = "pinki-vm"
  vm_size              = "Standard_B1s"
  admin_username       = "devopsadmin"
  admin_password       = "Admin@1234567"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "dev-nic-pinki"
  frontend_ip_name     = "dev-pip-todoapp-lb"
  vnet_name            = "dev-vnet-todoapp"
  frontend_subnet_name = "dev-frontend-subnet"
  nsg_name = "pinki-nsg"
}
module "public_ip_lb" {
  source              = "../../modules/azurerm_public_ip"
  public_ip_name      = "loadbalancer_ip"
  location            = "centralindia"
  resource_group_name = "dev-rg-todoapp"
  allocation_method   = "Static"
}

module "lb" {
  depends_on          = [module.public_ip_lb]
  source              = "../../modules/azurerm_loadbalancer"
 }

module "chinki_association" {
  source              = "../../modules/azurerm_nic_association"
  ip_configuration_name = "internal"
  nic_name            = "dev-nic-chinki"
  rg_name             = "dev-rg-todoapp"
  pool_name           = "BackendAddressPool"
  lb_name             = "TestLoadBalancer"
}
module "pinki_association" {
  depends_on          = [module.pinki_vm, module.lb]
  source              = "../../modules/azurerm_nic_association"
  ip_configuration_name = "internal"
  nic_name            = "dev-nic-pinki"
  rg_name             = "dev-rg-todoapp"
  pool_name           = "BackendAddressPool"
  lb_name             = "TestLoadBalancer"
}

module "bastion_subnet" {
  source              = "../../modules/azurerm_subnet"
  resource_group_name = "dev-rg-todoapp"
  virtual_network_name= "dev-vnet-todoapp"
  subnet_name         = "AzureBastionSubnet"
  address_prefixes    = ["10.0.2.0/27"]
}

module "public_ip_bastion" {
  source              = "../../modules/azurerm_public_ip"
  public_ip_name      = "dev-bastion-pip"
  location            = "centralindia"
  resource_group_name = "dev-rg-todoapp"
  allocation_method   = "Static"
  sku                 = "Standard"
}
module "bastion" {
  source              = "../../modules/azurerm_bastion"
  bastion_name        = "dev-bastion"
  location            = "centralindia"
  resource_group_name = "dev-rg-todoapp"
  subnet_id           = module.bastion_subnet.subnet_id
  public_ip_name     = "dev-bastion-pip"
}



