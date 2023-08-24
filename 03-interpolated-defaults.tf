data "azurerm_subscription" "current" {
}

locals {
  sdp_read_user = "SDP_READ_USER"

  sdp_cft_environments_map = {
    sandbox  = "sbox"
    aat      = "dev"
    perftest = "test"
  }

  sdp_environment = lookup(local.sdp_cft_environments_map, var.env, var.env)

  sdp_vault = {
    name = "mi-vault-${local.sdp_environment}"
    rg   = "mi-${local.sdp_environment}-rg"
  }
}
