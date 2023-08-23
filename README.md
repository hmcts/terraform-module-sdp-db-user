# terraform-module-sdp-db-user
Terraform module to add a database user to a specified database.

## Example

provider.tf
```hcl
provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "vault"
  subscription_id            = var.vault_subscription_id
}
```

postgres.tf
```hcl
module "sdp_db_user" {

  providers = {
    azurerm.vault = azurerm.vault
  }
  
  source = "git@github.com:hmcts/terraform-module-sdp-db-user?ref=master"
  env    = var.env
  
  database_name       = "${var.product}-${var.component}"
  database_host_name  = module.terraform-module-postgres-flexible.fqdn
  database_admin_user = module.terraform-module-postgres-flexible.username
  database_admin_pass = module.terraform-module-postgres-flexible.password
  
  common_tags = var.common_tags
}
```

variables.tf
```hcl
variable "vault_subscription_id" {} # details on how to retrieve this soon
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.7.0 |
| <a name="provider_azurerm.vault"></a> [azurerm.vault](#provider\_azurerm.vault) | >= 3.7.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.vault_sdp_read_user_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [null_resource.set-sdp-db-user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.sdp_read_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_key_vault.sdp_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_host_name"></a> [database\_host\_name](#input\_database\_host\_name) | Fully qualified domain name of the database to add the user to. | `string` | n/a | yes |
| <a name="input_database_admin_user"></a> [database\_admin\_user](#input\_database\_admin\_user) | Username of a database user with required permissions to create a read user. | `string` | n/a | yes |
| <a name="input_database_admin_pass"></a> [database\_admin\_pass](#input\_database\_admin\_pass) | Password of the database user. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sdp_username"></a> [username](#output\_username) | Username for the SDP database user created. |
| <a name="output_sdp_password"></a> [password](#output\_password) | Password for the SDP database user created. |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
