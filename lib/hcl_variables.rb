require "hcl_variables/version"

module HclVariables
  class Error < StandardError; end

  autoload :Parser, "hcl_variables/parser"

  def load(code)
    Parser.new(code).load
  end

  extend self
end
