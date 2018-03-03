variable "account_name" {}
variable "groups_to_attach" {
  type = "list"
  description = "List of group names to attach the policy to"
}
variable "role_name" {}
variable "role_arn_in_target_account" {}
