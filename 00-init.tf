terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.7.0"
      configuration_aliases = [azurerm.sdp_vault]
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.2.0"
    }
  }
}