terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45.0"
    }
  }
}
locals {
  volumes_flat = flatten([
    for server_name, server in var.servers : [
      for vol in server.volumes : {
        server_name = server_name
        volume_name = vol.name
        size        = vol.size
      }
    ]
  ])
}

resource "hcloud_server" "vm" {
  for_each = var.servers

  name              = each.key
  server_type       = each.value.server_type
  image             = var.image
  backups           = true
  delete_protection = true
}

resource "hcloud_volume" "volume" {
  for_each = {
    for vol in local.volumes_flat :
    "${vol.server_name}-${vol.volume_name}" => vol
  }

  name     = each.value.volume_name
  size     = each.value.size
  location = hcloud_server.vm[each.value.server_name].location
}

resource "hcloud_volume_attachment" "attach" {
  for_each = hcloud_volume.volume

  server_id = hcloud_server.vm[each.value.server_name].id
  volume_id = each.value.id
}
