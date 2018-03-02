resource "aws_iam_policy" "cross_account_policy" {
  name = "${var.policy_name}"
  policy =  "${var.policy_json}"
}

resource "aws_iam_role" "cross_account_role" {
  name = "${var.role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.cross_account_assume_role_policy.json}"
}

data "aws_iam_policy_document" "cross_account_assume_role_policy" {
  "statement" {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "arn:aws:iam::${var.source_account_id}:root"
      ]
      type = "AWS"
    }
  }
}
