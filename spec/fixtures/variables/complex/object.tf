variable "service_account" {
  default = null
  type = object({
    email  = string
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account."
}

variable "foo" {
  default = "bar"
  type = string
}

variable "networks" {
  type = map(object({
    network_number    = number
    availability_zone = string
    tags              = map(string)
  }))
}
