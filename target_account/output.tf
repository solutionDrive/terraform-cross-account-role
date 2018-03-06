output "role_arn" {
  value = "${aws_iam_role.cross_account_role.arn}"
}