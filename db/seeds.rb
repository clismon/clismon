
class Importer

  def initialize
    #ActiveRecord::Base.logger = Logger.new(STDOUT)
    Clip.destroy_all
    @output = RAILS_ROOT + "/public/miscosillas"
    Dir.mkdir(@output) unless File.exist?(@output)
    @base = RAILS_ROOT + "/content/"
    process(@base, load_entries(@base))
  end

  private
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
      clip.group = group
      clip.media.reprocess!
      puts clip.save ? "Clip #{name} in #{group} saved!" : "Problem saving #{name} in #{group}"
    end
  end

end

Importer.new

