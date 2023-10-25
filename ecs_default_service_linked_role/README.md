# ecs_default_service_linked_role

If you create a capacity provider in a clean account where the default service linked role does not exist then it will fail.

Use this module to import the existing role or create it when creating a new environment. Make sure that your ECS cluster module depends on this module as TerraForm is not able to derive an explicit dependency on this role.
