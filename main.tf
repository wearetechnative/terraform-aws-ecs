module "ecs_cluster" {
    source = "./ecs_clster/"
    name = "babis"
    #kms_key_arn = "arn:aws:kms:us-east-2:221539347604:key/12a30a23-5ca1-4553-a0de-3a1ca7c5b501"
    kms_key_arn = module.ecs_cluster.kms_key_arn
}

module "ecs_default_service_linked_role" {
    source = "./ecs_default_service_linked_role"
}

module "ecs_account_settings" {
    source = "./ecs_account_settings"
}

module "ecs_fargate_capacity_provider" {
    source = "./ecs_fargate_capacity_provider"
    ecs_cluster_arn = module.ecs_cluster.ecs_cluster_arn
    }
