# https://www.terraform.io/docs/configuration/variables.html

variable "docker_ports" {
  type = "list(object({
    internal = number
    external = number
    protocol = string
  }))"
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}