# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  cloud {
    organization = "JWHacks"
    workspaces {
      name = "jwhacks"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

# Create an Azure resource group
resource "azurerm_resource_group" "rg" {
  name     = "jwhacks"
  location = "westus2"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "jwhacks-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "westus2"
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a storage accoun
resource "azurerm_storage_account" "storage" {
  name                     = "jwhacksstorage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = "westus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}