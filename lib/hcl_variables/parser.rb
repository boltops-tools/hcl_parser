require "rhcl"

module HclVariables
  class Parser
    def initialize(raw)
      @raw = raw
    end

    def load
      return {} if empty? # Rhcl parser cannot handle empty file
      Rhcl.parse(code)
    end

    def code
      return @code if @code
      @code = fix_quotes(@raw)
      @code = remove_comments(@code)
    end

    def empty?
      lines = code.split("\n")
      lines.reject! { |l| l.strip.empty? }
      lines.empty?
    end

    def remove_comments(raw)
      lines = raw.split("\n")
      # filter out commented lines
      lines.reject! { |l| l =~ /(^|\s)#/i }
      # filter out empty lines
      lines.reject! { |l| l.strip.empty? }
      lines.join("\n")
    end

    def fix_quotes(raw)
      lines = raw.split("\n")
      lines.map! do |l|
        quote_line(l)
      end
      lines.join("\n")
    end

    def quote_line(l)
      return l unless l =~ /type\s*=/ # just check for type
      return l if l =~ /type\s*=\s*['"]([a-zA-Z0-9()]+)["']/ # check quotes in the type value

      # Reaching here means there's a type value without quotes
      # capture unquoted value so we can add quotes
      md = l.match(/type\s*=\s*([a-zA-Z0-9()]+)/)
      value = md[1]
      %Q|type = "#{value}"|
    end
  end
end
