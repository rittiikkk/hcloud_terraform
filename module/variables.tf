variable "servers" {
  type = map(object({
    server_type = string
    volumes     = list(object({
      name = string
      size = number
    }))
  }))
}
variable "image" {
  description = "The image to use for Hetzner server"
  type        = string
}