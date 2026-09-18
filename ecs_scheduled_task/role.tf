module "eventbridge_role" {
  source = "git::https://github.com/wearetechnative/terraform-aws-iam-role.git?ref=0fe916c27097706237692122e09f323f55e8237e"

  role_name = "${split("cluster/", data.aws_arn.ecs_cluster.resource)[1]}_${var.name}_scheduled_task_role"
  role_path = "/ecs/${split("cluster/", data.aws_arn.ecs_cluster.resource)[1]}/scheduled_task/"

  aws_managed_policies      = []
  customer_managed_policies = {
    "ecs_runtask": jsondecode(data.aws_iam_policy_document.runtask.json)
    "passrole": jsondecode(data.aws_iam_policy_document.passrole.json)
  }

  trust_relationship = {
    "events" : { "identifier" : "events.amazonaws.com", "identifier_type" : "Service", "enforce_mfa" : false, "enforce_userprincipal" : false, "external_id" : null, "prevent_account_confuseddeputy" : false }
  }
}

data "aws_iam_policy_document" "runtask" {
  statement {
    sid = "EventBridgeRunTask"

    actions = ["ecs:RunTask"]

    resources = [module.task_definition.task_definition_arn]

    condition {
      test     = "ArnEquals"
      variable = "ecs:cluster"
      values   = [var.ecs_cluster_arn]
    }
  }
}

data "aws_iam_policy_document" "passrole" {
  statement {
    sid = "EventBridgePassRole"

    actions = ["iam:PassRole"]

    resources = [var.task_role_arn, var.execution_role_arn]
  }
}
