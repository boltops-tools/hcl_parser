require "hcl_variables/version"

module HclVariables
  class Error < StandardError; end

  autoload :Parser, "hcl_variables/parser"
end
