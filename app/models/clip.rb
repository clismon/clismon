class Clip < ActiveRecord::Base
  has_attached_file :media, :styles => { :thumb => "100x100>" },
    :path => ":rails_root/public/miscosillas/:id/:style/:filename",
    :url => "/miscosillas/:id/:style/:filename"
  acts_as_list 
  before_save :save_dimensions

  def scope_condition
    "#{connection.quote_column_name("group")} = #{quote_value(group)}"
  end

  private
  def save_dimensions
    if media.image?
      self.width = media.width
      self.height = media.height
    end
  end
end
