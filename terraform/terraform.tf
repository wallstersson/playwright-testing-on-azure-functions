terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.89.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      # Prevents accidental deletion of resource groups, if you want to be able to delete the resource group even if it has resources not managed by terraform, change this to false.
      prevent_deletion_if_contains_resources = true
    } 
  }
}