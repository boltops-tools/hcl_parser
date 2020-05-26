require "hcl_parser/version"

module HclParser
  class Error < StandardError; end

  autoload :Loader, "hcl_parser/loader"

  def load(code)
    Loader.new(code).load
  end

  extend self
end
