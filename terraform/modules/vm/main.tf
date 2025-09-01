resource "azurerm_resource_group" "vm_rg" {
  name     = var.vm_resource_group_name
  location = var.location
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = var.vm_nic_nsg_name
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

  security_rule {
    name                       = "AllowHTTPFromLB"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSSHFromBastion"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.bastion_subnet_address_prefix
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = var.vm_nic_name
  location            = azurerm_resource_group.vm_rg.location
  resource_group_name = azurerm_resource_group.vm_rg.name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    subnet_id                     = var.vm_subnet_id
  }
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

module "vm_key_vault" {
  source = "../key_vault"

  subscription_id          = var.subscription_id
  kv_name                  = var.kv_name
  kv_resource_group_name   = var.vm_resource_group_name
  location                 = var.location
  whitelisted_ips          = var.whitelisted_ips
}

module "vm_disk_encryption_set" {
  source = "../vm_disk_encryption_set"

  vm_kv_id                       = module.vm_key_vault.key_vault_id
  vm_resource_group_name         = var.vm_resource_group_name
  location                       = var.location

  depends_on = [ module.vm_key_vault ]
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.vm_name
  resource_group_name             = azurerm_resource_group.vm_rg.name
  location                        = azurerm_resource_group.vm_rg.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  disable_password_authentication = true
  provision_vm_agent              = true

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
    disk_encryption_set_id = module.vm_disk_encryption_set.vm_encryption_set_id
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  depends_on = [ module.vm_disk_encryption_set ]
}

module "vm_backups" {
  source = "../vm_backups"

  vm_id = azurerm_linux_virtual_machine.vm.id
  vm_backup_rg = var.vm_resource_group_name
  vm_backup_recovery_vault_name = module.vm_key_vault.key_vault_name

  depends_on = [ module.vm_key_vault, azurerm_linux_virtual_machine.vm ]
}


module "monitor_diagnostic" {
  source              = "../monitor_diagnostic"
  la_workspace_name   = var.la_workspace_name
  audit_monitor_name  = var.audit_monitor_name
  monitor_rg_name     = azurerm_resource_group.vm_rg.name
  target_resource_id  = azurerm_linux_virtual_machine.vm.id
}