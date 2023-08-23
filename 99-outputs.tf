output "username" {
  value = local.sdp_read_user
}

output "password" {
  value = random_password.sdp_read_user_password.result
}
