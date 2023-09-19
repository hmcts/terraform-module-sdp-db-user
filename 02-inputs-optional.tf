variable "sdp_vault_name" {
  description = "Name of the vault to store the SDP read user password in."
  type        = string
  default     = null
}

variable "sdp_vault_rg_name" {
  description = "Name of the resource group the vault for the SDP read user password is in."
  type        = string
  default     = null
}

variable "sdp_read_username" {
  description = "Username of the SDP reader user."
  type        = string
  default     = null
}

variable "database_schemas" {
  description = "Map of databases on the server to their associated schemas to grant read permission to."
  type        = map(list(string))
  default     = {}
}