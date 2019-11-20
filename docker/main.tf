# Our input variables that we define in terraform.tfvars
variable "database_password_root" {}
variable "database_password_ghost" {}

terraform {
  required_version = ">= v0.12.0"

  required_providers {
    docker = ">= v2.5.0"
    mysql = ">= v1.9.0"
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "mysql" {
  endpoint = "localhost:3306"
  username = "root"
  password = var.database_password_root
}

# These could probably be input variables, but it's not a huge deal
locals {
  mysql_tag = "8.0.18"
  ghost_tag = "3.0.3"
}

module "network" {
  source = "./network"
}

module "mysql" {
  source = "./mysql"
  mysql_tag = local.mysql_tag
  network_id = module.network.network_id
  database_password_root = var.database_password_root
  database_password_ghost = var.database_password_ghost
}

module "ghost" {
  source = "./ghost"
  ghost_tag = local.ghost_tag
  network_id = module.network.network_id
  database_name = module.mysql.database_name
  database_user = module.mysql.database_user
  database_password_ghost = var.database_password_ghost
}
