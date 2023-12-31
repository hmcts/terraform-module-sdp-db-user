data "azurerm_subscription" "current" {
}

locals {
  sdp_read_user = coalesce(var.sdp_read_username, "SDP_READ_USER")

  sdp_vault = {
    name = coalesce(var.sdp_vault_name, "mi-vault-${var.env}")
    rg   = coalesce(var.sdp_vault_rg_name, "mi-${var.env}-rg")
  }
}
