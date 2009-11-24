module Clismon
  class Builder
    def initialize
      @out = ""
    end

    def write(text)
      @out << text
    end

    def tag(name, options = {}, &block)
      write("<#{name}")
      attributes(options)
      if block_given?
        write(">")
        yield(self)
        write("</#{name}>")
      else
        write(" />")
      end
    end

    def attributes(options)
      options.each do |key, val|
        write(" #{key}=\"#{expand_attribute(val)}\"")
      end
    end

    def expand_attribute(attribute)
      if attribute.is_a? String
        attribute
      elsif attribute.is_a? Hash
        result = ""
        attribute.each do |key, val|
          result << "#{key}: #{val}; "
        end
        result
      end
    end

    def to_s
      @out
    end
  end
end