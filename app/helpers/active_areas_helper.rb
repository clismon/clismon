
module ActiveAreasHelper
  def active_areas(id)
    area = ActiveArea.new(id)
    concat(area.before)
    yield area
    concat(area.after)
  end


  class ActiveArea
    def initialize(id)
      @parent_id = id
      @current_id = 0
    end

    def before
      <<-code
      var parent = $('#{@parent_id}');
      code
    end

    def after
      <<-code
      $('.activearea').css('border', '1px solid red');
      code
    end

    def create(x, y, width, height, url)
      @current_id += 1
      var = "area#{@current_id}"
      <<-code
      var #{var} = $('<div id="area#{@current_id}" class="activearea">&nbsp;</div>');
      parent.append(#{var});
      code
    end
  end
end