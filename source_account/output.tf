output "groups_associations" {
  value = "${aws_iam_policy_attachment.attach_devops_policy_to_groups.groups}"
}
