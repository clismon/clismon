
module LayersHelper
  def define_layers(base, width, height)
    layers = Layers.new(base, width, height)
    yield layers
    return layers
  end

  class Layers
    def initialize(base, width, height)
      @base = base
      @width = width
      @height = height
      @layers = []
      @background = nil
    end

    def background(name)
      @background = name
    end

    def layer(name,x,y,width,height)
      @layers << Layer.new(name,x,y,width,height)
    end

    def draw
      result = "<img id='background' src='#{@base}#{@background}' alt='background' class='layer' />"
      result << @layers.map{|layer| layer.draw(@base)}.join('')
      result.gsub(/'/, '"')
    end

    def draw_css
      result = ''
      @layers.each_with_index {|layer, index| result << "##{layer.name} {z-index: #{index + 2}; }\n" }
      result
    end

    private

  end

  class Layer
    attr_accessor :name, :x, :y, :width, :height
    def initialize(name, x, y, width, height)
      @name = name
      @x = x
      @y = y
      @width = width
      @height = height
    end

    def draw(base)
      <<-html
      <img id='#{name}' src='#{base}#{name}.png' alt='#{@name.gsub(/-/, ' ')}' class='layer activable' style='display: none' />
      html
    end
  end
end