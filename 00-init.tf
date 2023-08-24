terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.7.0"
      configuration_aliases = [azurerm.postgres_network, azurerm.vault]
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.2.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "vault"
  subscription_id            = local.environment[var.env].subscription
}