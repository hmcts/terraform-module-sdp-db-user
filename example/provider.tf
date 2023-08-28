provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "postgres_network"
  subscription_id            = var.aks_subscription_id
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "sdp_vault"
  subscription_id            = local.sdp_environment_ids[local.sdp_environment].subscription
}