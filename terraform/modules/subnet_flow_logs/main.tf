data "azurerm_network_watcher" "nw" {
  name                = var.network_watcher_name
  resource_group_name = var.network_watcher_rg
}

data "azurerm_storage_account" "existing" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.la_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_network_watcher_flow_log" "vm_subnet_logs" {
  name                    = var.vm_flow_logs_name
  network_watcher_name    = data.azurerm_network_watcher.nw.name
  resource_group_name     = data.azurerm_network_watcher.nw.resource_group_name
  target_resource_id      = var.vm_subnet_id
  storage_account_id      = data.azurerm_storage_account.existing.id
  enabled                 = true

  retention_policy {
    enabled = true
    days    = 30
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.main.workspace_id
    workspace_region      = data.azurerm_network_watcher.nw.location
    workspace_resource_id = azurerm_log_analytics_workspace.main.id
  }
}

resource "azurerm_network_watcher_flow_log" "bastion_subnet_logs" {
  name                    = var.bastion_flow_logs_name
  network_watcher_name    = data.azurerm_network_watcher.nw.name
  resource_group_name     = data.azurerm_network_watcher.nw.resource_group_name
  target_resource_id      = var.bastion_subnet_id
  storage_account_id      = data.azurerm_storage_account.existing.id
  enabled                 = true
  
  retention_policy {
    enabled = true
    days    = 30
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.main.workspace_id
    workspace_region      = data.azurerm_network_watcher.nw.location
    workspace_resource_id = azurerm_log_analytics_workspace.main.id
  }
}