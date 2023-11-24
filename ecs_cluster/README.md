# ecs_cluster

It's recommended to include ecs_settings as well in your main module.

We do not define CloudWatch logging on the cluster level, because this must be done in the service and task definition.
We do not define capacity providers in this module as we can do that externally. Also setting a default is something we do not want: it will not update existing services.
