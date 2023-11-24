# ecs_service

Module with dynamic support for most known scenarios:
- EC2 capacity providers with `ec2_asg` module.
- Fargate capacity providers.
- With or without load balancers.

Make sure you depend this module on an instance of ecs_default_service_linked_role so its created before creating this module. We rely on this role as default behaviour.

## Todo:

- Alert monitoring when max on scaling is reached this indicates higher than expected load or a bug.
