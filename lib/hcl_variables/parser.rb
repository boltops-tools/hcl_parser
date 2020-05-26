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

    # The parser being used cannot handle unquoted literal type values and comments.
    # Hacking it and updating the raw code as a workaround.
    # May have to fix the parser or write a new parser.
    def code
      return @code if @code
      @code = fix_quotes(@raw)
    end

    def empty?
      text = remove_comments(code)
      lines = text.split("\n")
      lines.reject! { |l| l.strip.empty? }
      lines.empty?
    end

    COMMENT_REGEX = /^(^|\s)#/i
    def remove_comments(raw)
      lines = raw.split("\n")
      # filter out commented lines
      lines.reject! { |l| l =~ COMMENT_REGEX }
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
      return "# " if l =~ COMMENT_REGEX # return empty comment so parser wont try to parse it
      return l unless l =~ /(type|default)\s*=/ # just check for type and default
      return l if l =~ /(type|default)\s*=\s*['"]([a-zA-Z0-9()]+)["']/ # check quotes in the type value

      # Reaching here means there is probably a type value without quotes
      # Try to capture unquoted value so we can add quotes
      md = l.match(/(type|default)\s*=\s*([a-zA-Z0-9()]+)/)

      if md
        prop, value = md[1], md[2]
        %Q|#{prop} = "#{value}"|
      else
        # Example: type = "list(object({
        l # unable to capture quotes, passthrough as fallback
      end
    end
  end
end
