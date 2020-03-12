# terraform-terragrunt-showcase

# Requirements

In order to deploy to *Datadog* export the following environment variables are needed:
```shell script
TF_VAR_datadog_api_key
TF_VAR_datadog_app_key
```

In order to deploy to *Kubernetes* export the following environment variables are needed:
```shell script
TF_VAR_kubernetes_cluster_ca_certificate
```

# Development

Get local AWS credentials on your machine first.

In order to develop locally, you can build (`task build`) and run an image (`task run-image`), which has all dependencies pre-installed.

Within the container you can run the tasks from the Taskfile (plan - `MY_TERRAGRUNT_WORKING_DIR=infrastructure-live/dev task plan-sequential`, apply - `MY_TERRAGRUNT_WORKING_DIR=infrastructure-live/dev task apply-sequential`) or use `terragrunt` directly.

Note: All files created within the container are created by _root_. In order to delete them, you can run the task `task clean-all`.

# Deployment roles

Terragrunt will assume specific IAM roles for deployment environments automatically.

These IAM roles are also used to authenticate against Kubernetes clusters automatically.
