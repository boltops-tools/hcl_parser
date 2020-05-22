variable "project" {
  description = "The name of the GCP Project where all resources will be launched."
  default     = "<%= ENV['GOOGLE_PROJECT'] %>"
  type        = string
}

variable "name_prefix" {
  type        = string
}

variable "example_list" {
  type    = list(string)
  default = []
}

# comment is a complex object that cannot be currently parsed on purpose
# variable "networks" {
#   type = map(object({
#     network_number    = number
#     availability_zone = string
#     tags              = map(string)
#   }))
# }
