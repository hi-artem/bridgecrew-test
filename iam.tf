resource "aws_iam_role" "role" {
  name               = var.role_name
  description        = var.description
  assume_role_policy = data.template_file.policy.rendered
}

data "template_file" "policy" {
  template = "${file("${path.module}/assume-role-policies/${var.assume_role_policy_name}.json.tpl")}"

  vars = {
    aws_account_id = var.aws_account_id
  }
}

resource "aws_iam_role_policy_attachment" "attach-iam-policy" {
  count      = length(var.role_policies)
  role       = aws_iam_role.role.name
  policy_arn = var.role_policies[count.index]

}
