resource "random_password" "sdp_read_user_password" {
  length = 20
  # safer set of special characters for pasting in the shell
  override_special = "()-_"
}

data "azurerm_key_vault" "sdp_vault" {
  provider            = azurerm.sdp_vault

  name                = local.sdp_vault.name
  resource_group_name = local.sdp_vault.rg
}

resource "azurerm_key_vault_secret" "sdp_vault_sdp_read_user_name" {
  provider     = azurerm.sdp_vault

  name         = "${var.server_name}-read-user-name"
  value        = local.sdp_read_user
  key_vault_id = data.azurerm_key_vault.sdp_vault.id
}

resource "azurerm_key_vault_secret" "sdp_vault_sdp_read_user_password" {
  provider     = azurerm.sdp_vault

  name         = "${var.server_name}-read-user-password"
  value        = random_password.sdp_read_user_password.result
  key_vault_id = data.azurerm_key_vault.sdp_vault.id
}

resource "null_resource" "setup_sdp_user" {
  for_each = { for index, db in var.databases : db.name => db }

  triggers = {
    script_hash       = filesha256("${path.module}/setup-sdp-user.bash")
    name              = var.server_name
    fqdn              = var.server_fqdn
    database          = each.value.name
    schemas           = join(",", lookup(var.database_schemas, each.value.name, []))
    sdp_reader_user   = local.sdp_read_user
    sdp_reader_pass   = random_password.sdp_read_user_password.result
  }

  provisioner "local-exec" {
    command = "${path.module}/setup-sdp-user.bash"

    environment = {
      DB_HOST_NAME    = var.server_fqdn
      DB_NAME         = each.value.name
      DB_ADMIN        = var.server_admin_user
      DB_PASSWORD     = var.server_admin_pass
      DB_SDP_USER     = local.sdp_read_user
      DB_SDP_PASS     = random_password.sdp_read_user_password.result
      DB_SCHEMAS      = join(",", lookup(var.database_schemas, each.value.name, []))
    }
  }

  depends_on = [
    azurerm_key_vault_secret.sdp_vault_sdp_read_user_name,
    azurerm_key_vault_secret.sdp_vault_sdp_read_user_password
  ]
}
