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