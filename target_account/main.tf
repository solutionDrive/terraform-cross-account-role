resource "aws_iam_policy" "cross_account_policy" {
  name = "${var.policy_name}"
  policy =  "${var.policy_json}"
}

resource "aws_iam_role" "cross_account_role" {
  name = "${var.role_name}"
  assume_role_policy = "${data.aws_iam_policy_document.cross_account_assume_role_policy_document.json}"
}

resource "aws_iam_role_policy_attachment" "cross_account_policy_attachment" {
  policy_arn = "${aws_iam_policy.cross_account_policy.arn}"
  role = "${aws_iam_role.cross_account_role.id}"
}

data "aws_iam_policy_document" "cross_account_assume_role_policy_document" {
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
  },
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = "${var.assume_account_arns}"
      type = "AWS"
    }
  }
}
