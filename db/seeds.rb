
class Importer

  def seed
    clean_database
    prepare_directories

    @images = RAILS_ROOT + "/content/images/"

    Group.create!(:name => 'fondos', :title => 'fondos', :section => false)

    import_images(@images, load_entries(@images))
    set_fondos
  end

  def set_fondos
    fondos = Group.find_by_name('fondos')
    fondos.update_attribute(:section, false)
    Group.all.each do |group|
      fondo = Clip.find_by_group_id_and_name(fondos.id, group.name)
      group.update_attribute(:background_id, fondo.id) if fondo
    end

  end

  def clean_database
    #ActiveRecord::Base.logger = Logger.new(STDOUT)
    Group.destroy_all
    Clip.destroy_all
  end

  def prepare_directories
    if RAILS_ENV != 'production'
      @output = RAILS_ROOT + "/public/miscosillas"
      FileUtils.remove_dir @output if File.exist?(@output)
      Dir.mkdir(@output)
    end
  end


  def load_entries(path)
    entries = []
    Dir.chdir(path) { entries = Dir["**/*.jpg", "**/*.gif", "**/*.png"] }
    entries
  end

  def import_images(base, entries)
    entries.each do |entry|
      puts "Process: #{entry}"
      lastBar = entry.rindex('/')
      group = entry[0..(lastBar - 1)]
      name = entry[(lastBar + 1)..-1]
      path = File.join(base, entry)
      clip = Clip.create
      clip.media = File.new(path)
      realname = name[0..(name.rindex('.') - 1)].gsub(/-/, ' ')
      clip.name = realname
      clip.group = Group.find_or_create_by_name(group)
      clip.media.reprocess!
      puts clip.save ? "Clip #{name} in #{group} saved!" : "Problem saving #{name} in #{group}"
    end
  end
end


Importer.new.seed

