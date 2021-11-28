require "rhcl"

module HclParser
  class Loader
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
      @code = rewrite_complex_types(@code)
    end

    def rewrite_complex_types(raw)
      lines = raw.split("\n")
      results = []

      variable_start_found = false
      variable_start_index = nil
      variable_end_index = nil
      rewrite_lines = false

      lines.each_with_index do |l,i|
        # We dont rewrite lines until the next line/iteration
        # This is actually the next iteration since we set rewrite_lines = true previously
        # in rewrite_lines = complex_type_lines?(lookahead_lines)
        if rewrite_lines
          if complex_type_line?(l)
            # Doesnt matter what the default value is as long as there is one
            # Doing this in case the default value spans multiple lines
            results << '  default = "any"'
          elsif simple_default_assignment?(l)
            results << l
          else
            results << "# #{l}"
          end
        else
          results << l
        end
        # End of logic in the next iteration

        # Start of logic in the current iteration
        variable_start_found = l.match(/^variable /)
        if variable_start_found
          variable_start_index = i
          variable_end_index = variable_end_index(lines, variable_start_index)
          lookahead_lines = lines[variable_start_index..variable_end_index]
          rewrite_lines = complex_type_lines?(lookahead_lines)
        end

        # Disable rewriting before reaching the end of the variable definition so: i + 1
        if variable_end_index == i + 1
          variable_start_index = nil
          variable_end_index = nil
          rewrite_lines = false
        end
      end

      results.join("\n")
    end

    def simple_default_assignment?(line)
      line.match(/default\s*=\s*("|'|null)/)
    end

    def complex_type_lines?(lines)
      !!lines.find do |l|
        complex_type_line?(l)
      end
    end

    def complex_type_line?(l)
      l.match(/object\(/) || l.match(/=\s*"any/)
    end

    def variable_end_index(lines, variable_start_index)
      end_variable_index = nil
      lines.each_with_index do |l,i|
        next unless i > variable_start_index
        return i if l.match(/^}/)
      end
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
