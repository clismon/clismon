class Clip < ActiveRecord::Base
  belongs_to :group
  has_attached_file :media, :styles => { :thumb => "100x100>" },
    :path => ":rails_root/public/miscosillas/:id/:style/:filename",
    :url => "/miscosillas/:id/:style/:filename"
  default_scope :order => 'name'

  validates_presence_of :name

  def width
    media.image? ? media.width : 0
  end

  def height
    media.image? ? media.height : 0
  end
end
