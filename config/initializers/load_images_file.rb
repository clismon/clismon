
require 'yaml'

class Imagify
  data = YAML.load_file("#{RAILS_ROOT}/config/images.yml")
  IMAGES = data['images']
  GROUPS = data['groups']


  def self.groups
    GROUPS.keys
  end

  def self.group(group)
    puts "Imagify GRP: #{group}"
    GROUPS[group]
  end

  def self.image(name)
    puts "Imagify IMG: #{name}"
    IMAGES[name]
  end
end
