resource "aws_iam_policy" "assume_devops_policy" {
  name = "Assume${var.role_name}"
  description = "Assume ${var.role_name} in ${var.account_name} account"
  policy = "${var.assume_policy}"
}

resource "aws_iam_policy_attachment" "attach_devops_policy_to_groups" {
  name = "Attach DevOps Policy for ${var.account_name}"
  groups = ["${var.groups_to_attach}"]
  policy_arn = "${aws_iam_policy.assume_devops_policy.arn}"
}
