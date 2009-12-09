
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

    def layers(layers)
      @layers += layers
    end

    def draw
      result = draw_layer('background', @background, 'background')
      @layers.each do |name|
        result << draw_layer(name, name + '.png', name.gsub(/-/, ' '), 'activable', 'display: none;')
      end
      result.gsub(/'/, '"')
    end

    def draw_css
      result = ''
      @layers.each_with_index {|name, index| result << "##{name} {z-index: #{index + 2}; }\n" }
      result
    end

    private
    def draw_layer(id, file, alt, css_class = '', style = '')
      "<img id='#{id}' src='#{@base}#{file}' alt='#{alt}' class='layer #{css_class}' style='#{style}' />\n"
    end
  end
end