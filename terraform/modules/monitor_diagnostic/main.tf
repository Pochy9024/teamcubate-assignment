data "azurerm_storage_account" "existing" {
  name                = var.storage_account_name
  resource_group_name = var.storage_resource_group
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = var.la_workspace_name
  location            = var.location
  resource_group_name = var.monitor_rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

data "azurerm_monitor_diagnostic_categories" "main" {
  resource_id = var.target_resource_id
}

resource "azurerm_monitor_diagnostic_setting" "main" {
  name                       = var.audit_monitor_name
  target_resource_id         = var.target_resource_id
  storage_account_id         = data.azurerm_storage_account.existing.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.main.log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.main.metrics
    content {
      category = enabled_metric.value
    }
  }
}