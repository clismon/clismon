class Clip < ActiveRecord::Base
  has_attached_file :media, :styles => { :thumb => "100x100>" },
    :path => ":rails_root/public/miscosillas/:id/:style/:filename",
    :url => "/miscosillas/:id/:style/:filename"
end
