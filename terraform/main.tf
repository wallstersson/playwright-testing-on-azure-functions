# This terraform file creates base resources needed for availability testing

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.name}-law"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# Create a application insights
resource "azurerm_application_insights" "ai" {
  name                = "${var.name}-ai"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.law.id
}

# Create a storage account
resource "azurerm_storage_account" "sa" {
  name                     = "${var.name}sa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a app service plan of type consumption to be used by the function app
resource "azurerm_app_service_plan" "asp" {
  name                = "${var.name}-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "FunctionApp"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

# Output variables
output "function_app_name" {
  value = azurerm_function_app.fa.name
  description = "The name of the function app"
}

# Output resource_group_name
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
  description = "The name of the resource group"
}
