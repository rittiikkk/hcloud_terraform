terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45.0"
    }
  }
}
provider "hcloud" {
  token = var.hcloud_token
}

module "servers" {
  source  = "./module/"
  servers = var.servers
  image   = var.image

  providers = {
    hcloud = hcloud
  }
}

