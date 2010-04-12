
class Importer

  def initialize
    clean_database
    prepare_directories

    fondos = Group.create!(:name => 'fondos', :section => false)
    Group.create!(:name => 'blog', :section => false)
    Group.create!(:name => 'dinero', :title => 'Dinero', :section => true, :resize_method => 'height', :color => '#FAC9C2')

    @images = RAILS_ROOT + "/content/images/"
    process(@images, load_entries(@images))

    @vacio = Clip.find_by_group_id_and_name(fondos.id, 'vacio')
    Group.all.each do |group|
      group.update_attribute(:background_id, @vacio.id)
    end

  end

  def clean_database
    #ActiveRecord::Base.logger = Logger.new(STDOUT)
    Group.destroy_all
    Clip.destroy_all
  end

  def prepare_directories
    @output = RAILS_ROOT + "/public/miscosillas"
    FileUtils.remove_dir @output
    Dir.mkdir(@output) unless File.exist?(@output)
  end


  def load_entries(path)
    entries = []
    Dir.chdir(path) { entries = Dir['**/*.jpg'] }
    entries
  end

  def process(base, entries)
    entries.each do |entry|
      lastBar = entry.rindex('/')
      group = entry[0..(lastBar - 1)]
      name = entry[(lastBar + 1)..-1]
      path = File.join(base, entry)
      clip = Clip.create
      clip.media = File.new(path)
      clip.name = name[0..(name.rindex('.') - 1)].gsub(/-/, ' ')
      clip.group = Group.find_or_create_by_name(group)
      clip.media.reprocess!
      puts clip.save ? "Clip #{name} in #{group} saved!" : "Problem saving #{name} in #{group}"
    end
  end

end

Importer.new

