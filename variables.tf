variable "hcloud_token" {
  description = "Hetzner Cloud API Token"
  type        = string
  sensitive   = true
}

variable "servers" {
  description = "Map of server names to server configuration"
  type = map(object({
    server_type = string
    volumes = list(object({
      name = string
      size = number
    }))
  }))
}
variable "image" {
  description = "The image to use for Hetzner server"
  type        = string
  default     = "ubuntu-22.04"
}

