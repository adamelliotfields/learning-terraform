# Learning Terraform: Docker

This example uses Terraform to create a Docker network, create volumes, pull images, and start
containers.

In order to control the flow of execution (we need the database to exist before the app), we use
output variables.

As an extra example, the MySQL provider is used to create the database user.

## Input Variables

Put these in `terraform.tfvars` in the `docker` subfolder.

```hcl
database_password_root = "root"
database_password_ghost = "ghost"
```
