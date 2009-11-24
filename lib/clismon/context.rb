
module Clismon
  class Context
    attr_reader :base
    attr_accessor :output

    def initialize(base, file)
      @base = base
      @file = file
    end

    def read_source
      File.new(File.join(base, @file)).read
    end

    def path(name)
      File.join(@base, name)
    end

    def use(name)
      
    end

    def image_size(name)
      ImageSize.new(File.new(path(name)).read)
    end
  end
end