resource "azurerm_lb" "lb" {
  name                = "TestLoadBalancer"
  location            = "central india"
  resource_group_name = "dev-rg-todoapp"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = data.azurerm_public_ip.pip.id  
}
}
resource "azurerm_lb_backend_address_pool" "pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackendAddressPool"
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "HealthProbe"
  protocol        = "Tcp"
  port            = 80
}
resource "azurerm_lb_rule" "rule" {
  loadbalancer_id            = azurerm_lb.lb.id
  name                       = "lbrule"
  protocol                   = "Tcp"
  frontend_port              = 80
  backend_port               = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                   = azurerm_lb_probe.probe.id
}