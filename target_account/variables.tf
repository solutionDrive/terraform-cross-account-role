variable "policy_name" {}
variable "policy_json" {}
variable "role_name" {}
variable "role_description" {
  default = "Role for Cross Account Access"
}
variable "source_account_id" {}
variable "assume_account_arns" {
  description = "Multiple account arns which should be passed to the assume policy (for example 'arn:aws:iam::123456789876543:root')"
  type = "list"
  default = []
}
