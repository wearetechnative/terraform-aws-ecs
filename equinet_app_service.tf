#Create service for Equinet rails app
resource "aws_ecs_service" "equinet_app_service" {
  name            = "equinet-app-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.equinet_app_task_definition.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.equinet_app_target_group.arn
    container_name   = "equinet-app-container"
    container_port   = var.equinet_app_port
  }

  network_configuration {
    security_groups = [module.network.default_security_group_id]
    subnets         = module.network.private_subnets
  }
}
