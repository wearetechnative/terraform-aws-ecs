resource "aws_iam_policy" "ssm_session" {
  name        = "${var.name}-ssm-session"
  path        = "/"
  description = ""

  policy = data.aws_iam_policy_document.ssm_session.json
}

data "aws_iam_policy_document" "ssm_session" {
  statement {
    sid = "SSMSessionExecuteCommand"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "ssm_session" {
  role       = local.task_role_name
  policy_arn = aws_iam_policy.ssm_session.arn
}
