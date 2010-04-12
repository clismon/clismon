class Group < ActiveRecord::Base
  has_many :clips
  belongs_to :background, :class_name => 'Clip'
  before_save :create_title

  def to_param
    name
  end

  def background_url
    self.background.media.url if self.background_id
  end

  def background_width
    self.background.width if self.background_id
  end

  def background_height
    self.background.height if self.background_id
  end

  private
  def create_title
    self.title = self.name if self.title.nil?
  end
end
