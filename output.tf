 # Create outputs for 
 # the URL of the Equinet rails app load balancer, 
 # the ARN of the Equinet rails app task definition,
 # the name and ARN of the Equinet rails app service,
 # the desired, running, and pending counts of tasks for the Equinet rails app service,
 # the ARNs of the CPU and memory utilization cloudwatch alarms for the Equinet rails app

output "equinet_app_url" {
  description = "The URL of the Rails app load balancer"
  value       = "http://${aws_lb.equinet_app_lb.dns_name}"
}

output "equinet_app_task_definition_arn" {
  description = "The ARN of the Rails app task definition"
  value       = aws_ecs_task_definition.equinet_app_task_definition.arn
}

output "equinet_app_service_name" {
  description = "The name of the Rails app service"
  value       = aws_ecs_service.equinet_app_service.name
}

output "equinet_app_service_arn" {
  description = "The ARN of the Rails app service"
  value       = aws_ecs_service.equinet_app_service.arn
}

output "equinet_app_service_desired_count" {
  description = "The desired count of tasks for the Rails app service"
  value       = aws_ecs_service.equinet_app_service.desired_count
}

output "equinet_app_service_running_count" {
  description = "The running count of tasks for the Rails app service"
  value       = aws_ecs_service.equinet_app_service.running_count
}

output "equinet_app_service_pending_count" {
  description = "The pending count of tasks for the Rails app service"
  value       = aws_ecs_service.equinet_app_service.pending_count
}

output "equinet_app_cpu_alarm_arn" {
  description = "The ARN of the CPU utilization CloudWatch alarm for the Rails app"
  value       = aws_cloudwatch_metric_alarm.equinet_app_cpu_alarm.arn
}

output "equinet_app_memory_alarm_arn" {
  description = "The ARN of the memory utilization CloudWatch alarm for the Rails app"
  value       = aws_cloudwatch_metric_alarm.equinet_app_memory_alarm.arn
}
