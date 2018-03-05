variable "account_name" {}
variable "assume_policy" {
  type = "string"
  description = "Policy in json-format to define assume-Conditions"
}
variable "groups_to_attach" {
  type = "list"
  description = "List of group names to attach the policy to"
}
variable "role_name" {}
