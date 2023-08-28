module "postgresql" {

  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }

  source = "git@github.com:hmcts/terraform-module-postgresql-flexible?ref=master"
  env    = var.env

  product       = "sdp"
  component     = "example"
  business_area = "sds"

  common_tags = module.common_tags.common_tags
  pgsql_databases = [
    {
      name : "application"
    }
  ]
  pgsql_version = "14"
}

module "sdp_read_user" {

  providers = {
    azurerm.postgres_network = azurerm.postgres_network
    azurerm.sdp_vault        = azurerm.sdp_vault
  }
  
  source = "../"
  env    = var.env

  env    = local.sdp_environment

  server_name       = "sdp-example"
  server_fqdn       = module.postgresql.fqdn
  server_admin_user = module.postgresql.username
  server_admin_pass = module.postgresql.password
  databases         = [
    {
      name : "application"
    }
  ]

  common_tags = module.common_tags.common_tags
}

# only for use when building from ADO and as a quick example to get valid tags
# if you are building from Jenkins use `var.common_tags` provided by the pipeline
module "common_tags" {
  source = "github.com/hmcts/terraform-module-common-tags?ref=master"

  builtFrom   = "hmcts/terraform-module-sdp-db-user"
  environment = var.env
  product     = "sdp"
}
