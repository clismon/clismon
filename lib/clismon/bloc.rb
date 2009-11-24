module Clismon
  class Bloc
    attr_reader :style

    def initialize(options, &block)
      @options = options
      @style = {}
      @children = []
      self.instance_eval(&block) if block_given?
    end

    def attr(name)
      @options[name]
    end

    # required attribute
    def attr!(name)
      raise Exception.new unless @options[name]
      @options[name]
    end

    def css(name, value)
      @style[name] = value
    end

    def image(options)
      @children << Image.new(options)
    end
  end
end