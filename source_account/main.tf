resource "aws_iam_policy" "assume_devops_policy" {
  name = "Assume${var.role_name}"
  description = "Assume ${var.role_name} in ${var.account_name} account"
  policy = "${data.aws_iam_policy_document.assume_devops_policy.json}"
}

data "aws_iam_policy_document" "assume_devops_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "${var.role_arn_in_target_account}"
    ]
  }
}

resource "aws_iam_policy_attachment" "attach_devops_policy_to_groups" {
  name = "Attach DevOps Policy for ${var.account_name}"
  groups = ["${var.groups_to_attach}"]
  policy_arn = "${aws_iam_policy.assume_devops_policy.arn}"
}
