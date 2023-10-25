# ecs_fargate_capacity_provider

It's recommended to include ecs_settings as well in your main module.

Make sure you depend on ecs_default_service_linked_role to allow this module to work on clean accounts. This will setup the initial default service linked role otherwise this module will initially fail.

If you still get the error below then you must wait a while and rerun TerraForm again for creation to complete.
`Error: error updating ECS Cluster (<var.name>) Capacity Providers: InvalidParameterException: Unable to assume the service linked role. Please verify that the ECS service linked role exists.`
