# https://www.hashicorp.com/blog/terraform-0-12-rich-value-types/

variable "networks" {
  type = map(object({
    network_number    = number
    availability_zone = string
    tags              = map(string)
  }))
}
