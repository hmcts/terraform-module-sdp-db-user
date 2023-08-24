variable "env" {
  description = "Environment value."
  type        = string
}

variable "common_tags" {
  description = "Common tag to be applied to resources."
  type        = map(string)
}

variable "server_name" {
  description = "Name of the server."
  type        = string
}

variable "server_fqdn" {
  description = "Fully qualified domain name of the server to add the user to."
  type        = string
}

variable "server_admin_user" {
  description = "Username of a server admin user with required permissions to create a read user."
  type        = string
}

variable "server_admin_pass" {
  description = "Password of the server admin user."
  type        = string
  sensitive   = true
}

variable "databases" {
  description = "List of databases on the server to grant permissions to the SDP user."
  type        = list(object({ name : string, collation : optional(string), charset : optional(string) }))
}