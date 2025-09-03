resource "azurerm_public_ip" "lb_public_ip" {
  name                = var.lb_public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.lb_frontend_ip_name
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  name                = var.lb_backend_address_pool_name
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "http_probe" {
  name                = var.lb_http_probe_name
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_frontend_ip_name
  probe_id                       = azurerm_lb_probe.http_probe.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend.id]
}

resource "azurerm_network_interface_backend_address_pool_association" "vm_lb_association" {
  network_interface_id    = var.vm_nic_id
  ip_configuration_name   = var.vm_nic_ip_config_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend.id
}