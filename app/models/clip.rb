class Clip < ActiveRecord::Base
  has_attached_file :media, :styles => { :thumb => "100x100>" }
end
