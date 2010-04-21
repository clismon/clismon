
class Importer

  def initialize
    clean_database
    prepare_directories

    fondos = Group.create!(:name => 'fondos', :section => false)
    Group.create!(:name => 'blog', :section => false)
    Group.create!(:name => 'dinero', :title => 'Dinero', :section => true, :resize_method => 'height', :color => '#FAC9C2')

    @images = RAILS_ROOT + "/content/images/"
    @posts = RAILS_ROOT + "/content/posts"
    
    import_posts(@posts, load_entries(@posts, 'txt'))
    import_images(@images, load_entries(@images, 'jpg'))

    @vacio = Clip.find_by_group_id_and_name(fondos.id, 'vacio')
    Group.all.each do |group|
      group.update_attribute(:background_id, @vacio.id)
    end

    

  end

  def clean_database
    #ActiveRecord::Base.logger = Logger.new(STDOUT)
    Group.destroy_all
    Clip.destroy_all
    Post.destroy_all
  end

  def prepare_directories
    if RAILS_ENV != 'production'
      @output = RAILS_ROOT + "/public/miscosillas"
      FileUtils.remove_dir @output if File.exist?(@output)
      Dir.mkdir(@output)
    end
  end


  def load_entries(path, extension)
    entries = []
    Dir.chdir(path) { entries = Dir["**/*.#{extension}"] }
    entries
  end

  def import_images(base, entries)
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

  def import_posts(base, entries)
    entries.each do |entry|
      name = entry
      path = File.join(base, entry)
      post = Post.new
      post.title = name
      File.open(path, "r") {|f| post.body = f.readlines.join}
      puts post.save ? "Post #{name} saved!" : "Problem saving post #{name}"
    end
  end
end


Importer.new

