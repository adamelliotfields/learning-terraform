variable "hcloud_token" {}
variable "rsa_public" {}
variable "rsa_private" {}

variable "user" {
  type = string
  default = "adam"
}

variable "server_count" {
  type = number
  default = 2
}

terraform {
  required_version = ">= v0.12.0"

  required_providers {
    hcloud = ">= v1.15.0"
  }

  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

module "access" {
  source = "./modules/access"
  rsa_public = var.rsa_public
}

module "networks" {
  source = "./modules/networks"
}

module "servers" {
  source = "./modules/servers"
  user = var.user
  rsa_public = var.rsa_public
  rsa_private = var.rsa_private
  server_count = var.server_count
  network_id = module.networks.network_id
}
