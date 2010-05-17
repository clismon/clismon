class Clip < ActiveRecord::Base
  belongs_to :group
  has_attached_file :media, :styles => { :thumb => "100x100>" },
    :path => ":rails_root/public/miscosillas/:id/:style/:filename",
    :url => "/miscosillas/:id/:style/:filename"
  before_save :save_dimensions
  default_scope :order => 'name'

  private
  def save_dimensions
    if media.image?
      self.width = media.width
      self.height = media.height
    end
  end
end
