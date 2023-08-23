terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.7.0"
      configuration_aliases = [azurerm.postgres_network]
    }
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.7.0"
      alias                 = "vault"
      configuration_aliases = [azurerm.vault]
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.2.0"
    }
  }
}