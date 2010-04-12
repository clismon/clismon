# Para salvar a altura e largura das imagens enviadas pelo plugin paperclip, utilize o callback abaixo
# http://gist.github.com/10790
# 
# class Document < ActiveRecord::Base
#
#   has_attached_file :document, :styles => { :medium => "300x300>" }
#
#   before_save :save_dimensions
#
#   def save_dimensions
#     if document.image?
#       self.width = document.width
#       self.height = document.height
#     end
#   end
#
# end

module Paperclip
  class Attachment
    def width(style = default_style)
      Paperclip::Geometry.from_file(to_file(style)).width
    end

    def height(style = default_style)
      Paperclip::Geometry.from_file(to_file(style)).height
    end

    def image?(style = default_style)
      file = to_file(style)
      file.nil? ? false : file.image?
    end
  end

  module Upfile
    def image?
      ["image/jpeg", "image/tiff", "image/png", "image/gif", "image/bmp"].include?(content_type)
    end
  end
end