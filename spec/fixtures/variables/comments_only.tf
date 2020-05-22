# variable "project" {
#   description = "The name of the GCP Project where all resources will be launched."
#   default     = "<%= ENV['GOOGLE_PROJECT'] %>"
#   type        = string
# }
#
# variable "name_prefix" {
#   type        = string
# }
#
# variable "example_list" {
#   type    = list(string)
#   default = []
# }

# variable "networks" {
#   type = map(object({
#     network_number    = number
#     availability_zone = string
#     tags              = map(string)
#   }))
# }


# variable "docker_ports" {
#   type = "list(object({
#     internal = number
#     external = number
#     protocol = string
#   }))"
#   default = [
#     {
#       internal = 8300
#       external = 8300
#       protocol = "tcp"
#     }
#   ]
# }