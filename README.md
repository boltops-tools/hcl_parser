# HclVariables

Parse HCL Variables files. The scope of this library is to only handle variables file.

## Usage

```ruby
require "hcl_variables"
code =<<EOL
variable "project" {
  description = "The name of the GCP Project"
  default     = "test"
  type        = "string"
}
variable "name_prefix" {
  type        = "string"
}
EOL

parser = HclVariables::Parser.new(code)
parser.load
# Returns =>
#
# {"variable"=>
#   {"project"=>
#     {"description"=>"The name of project",
#      "default"=>"test",
#      "type"=>"string"},
#    "name_prefix"=>{"type"=>"string"}}}
```

## Installation

```ruby
gem 'hcl_variables'
```
