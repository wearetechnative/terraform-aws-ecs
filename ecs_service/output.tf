output "ecs_service_arn" {
  value = aws_ecs_service.this.id
}

output "ecs_task_definition_arn" {
  value = module.task_definition.task_definition_arn
}
