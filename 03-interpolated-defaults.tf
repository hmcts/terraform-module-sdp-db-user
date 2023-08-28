data "azurerm_subscription" "current" {
}

locals {
  sdp_read_user = "SDP_READ_USER"

  sdp_vault = {
    name = coalesce(var.sdp_vault_name, "mi-vault-${var.sdp_environment}")
    rg   = coalesce(var.sdp_vault_rg_name, "mi-${var.sdp_environment}-rg")
  }
}
