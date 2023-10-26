module "iam_role" {
  source = "../../../identity_and_access_management/iam_role"

  role_name = var.name
  role_path = "/ecs-dns-lambda/"

  aws_managed_policies = []
  customer_managed_policies = {
    "sqs_dlq" : jsondecode(data.aws_iam_policy_document.sqs_dlq.json)
    "ec2_eni_and_route53" : jsondecode(data.aws_iam_policy_document.ec2_eni_and_route53.json)
  }

  trust_relationship = {
    "ec2" : { "identifier" : "lambda.amazonaws.com", "identifier_type" : "Service", "enforce_mfa" : false, "enforce_userprincipal" : false, "external_id" : null, "prevent_account_confuseddeputy" : false }
  }
}

data "aws_iam_policy_document" "sqs_dlq" {
  statement {
    sid = "AllowDLQAccess"

    actions = ["sqs:SendMessage"]

    resources = [var.sqs_dlq_arn]
  }
}

data "aws_route53_zone" "this" {
  zone_id = var.hosted_zone_id
}

data "aws_iam_policy_document" "ec2_eni_and_route53" {
  statement {
    sid = "LambdaEni"

    actions = ["ec2:DescribeNetworkInterfaces"]

    resources = ["*"]
  }

  statement {
    sid = "LambdaHostedZone"

    actions = ["route53:GetHostedZone", "route53:ChangeResourceRecordSets"]

    resources = [data.aws_route53_zone.this.arn]
  }
}
