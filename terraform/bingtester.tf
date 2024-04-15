# Test specific variables for bing availability test

variable "function_name" {
  default     = "bing-tester"
  description = "Prefix for the function name"
}

variable "test_name" {
  default     = "Bing availability"
  description = "Name of the availability test"
}

variable "test_url" {
  default     = "https://www.bing.com"
  description = "URL to test"
}

# Create a function app
resource "azurerm_function_app" "fa" {
  name                       = "${var.function_name}-fa"
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.asp.id
  storage_account_name       = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  version                    = "~4"
  os_type                    = "linux"

  site_config {
    linux_fx_version = "node|20"
  }

  app_settings = {
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = azurerm_application_insights.ai.connection_string
      "AVAILABILITY_TEST_NAME" = "${var.test_name}"
      "FUNCTIONS_WORKER_RUNTIME" = "node"
      "PLAYWRIGHT_BROWSERS_PATH" = 0
      "RUN_LOCATION" = azurerm_resource_group.rg.location
      "WEB_URL" = "${var.test_url}"
      "WEBSITE_CONTENTAZUREFILECONNECTIONSTRING" = azurerm_storage_account.sa.primary_connection_string
      "WEBSITE_CONTENTSHARE" = "${var.function_name}-fa"
  }
}
