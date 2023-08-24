# terraform-module-sdp-db-user
Terraform module to add a read only SDP user to a specified databases.

## Example

provider.tf
```hcl
provider "azurerm" {
  features {}
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  alias                      = "postgres_network"
  subscription_id            = var.aks_subscription_id
}
```

postgres.tf
```hcl
module "sdp_db_user" {

  providers = {
    azurerm.postgres_network = azurerm.postgres_network
  }

  source = "git@github.com:hmcts/terraform-module-sdp-db-user?ref=master"
  env    = var.env

  server_name       = "${var.product}-${var.component}"
  server_fqdn       = module.terraform-module-postgres-flexible.fqdn
  server_admin_user = module.terraform-module-postgres-flexible.username
  server_admin_pass = module.terraform-module-postgres-flexible.password
  databases         = var.databases

  common_tags = var.common_tags
}
```

variables.tf
```hcl
variable "aks_subscription_id" {} # provided by the Jenkins library, ADO users will need to specify this
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
| <a name="provider_azurerm.postgres_network"></a> [azurerm.postgres\_network](#provider\_azurerm.postgres\_network) | >= 3.7.0 |
| <a name="provider_azurerm.vault"></a> [azurerm.vault](#provider\_azurerm.vault) | >= 3.7.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_secret.vault_sdp_read_user_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [null_resource.setup-sdp-db-user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.sdp_read_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_key_vault.sdp_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources. | `map(string)` | n/a | yes |
| <a name="input_databases"></a> [databases](#input\_databases) | List of databases on the server to grant permissions to the SDP user. | `list(object)` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment value. | `string` | n/a | yes |
| <a name="input_server_admin_pass"></a> [server\_admin\_pass](#input\_server\_admin\_pass) | Password of the server admin user. | `string` | n/a | yes |
| <a name="input_server_admin_user"></a> [server\_admin\_user](#input\_server\_admin\_user) | Username of a server admin user with required permissions to create a read user. | `string` | n/a | yes |
| <a name="input_server_fqdn"></a> [server\_fqdn](#input\_server\_fqdn) | Fully qualified domain name of the server to add the user to. | `string` | n/a | yes |
| <a name="input_server_name"></a> [server\_name](#input\_server\_name) | Name of the server. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sdp_password"></a> [password](#output\_password) | Password for the SDP user created. |
| <a name="output_sdp_username"></a> [username](#output\_username) | Username for the SDP user created. |

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
