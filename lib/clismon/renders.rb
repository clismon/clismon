module Clismon
  class Image < Bloc
    def render(page, ctx)
      ctx.use attr!(:src)
      size = ctx.image_size attr(:src)
      page.tag(:img, :src => attr(:src),
        :style => {:width =>  "#{size.w}px", :height => "#{size.h}px"})
    end
  end

  class Page < Bloc
    def render(page, ctx)
      page.write '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"'
      page.write '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">'
      page.tag(:html) do
        page.tag(:head) do
          page.tag(:title) { page.write self.attr!(:title) }
        end
        page.tag(:body) do
          @children.each  {|child| child.render(page, ctx)}
        end
      end
    end
  end
end