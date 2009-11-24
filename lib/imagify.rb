$:.unshift File.dirname(__FILE__)     # For use/testing when no gem is installed

# rubygems
require 'rubygems'

# core
require 'fileutils'
require 'time'
#require 'yaml'

# stdlib
require 'ya2yaml'

# 3rd party
require 'image_size'

module Imagify
  class App
    def initialize
      @images = {}
      @groups = {}
    end

    def run
      base = 'public/images/'
      process(base, load_entries(base))
      write('config/images.yml')
      puts @images.to_yaml
    end
    
    private
    def load_entries(path)
      base = File.join('.', path)
      entries = []
      Dir.chdir(base) { entries = Dir['**/*.jpg'] }
      entries
    end

    def process(base, entries)
      entries.each do |entry|
        lastBar = entry.rindex('/')
        group = entry[0..(lastBar - 1)]
        name = entry[(lastBar + 1)..-1]
        path = File.join(base, entry)
        size = ImageSize.new(File.new(path).read)
        add(group, name, size.w, size.h)
      end
    end

    def write(filename)
      path = File.join('.', filename)
      File.open(path, "w") do |f|
        f.write({'images' => @images, 'groups' => @groups}.to_yaml)
      end
    end

    def add(group, name, width, height)
      @images[name] = {
        'name' => name, 'group' => group, 'path' => "#{group}/#{name}",
        'width' => width, 'height' => height
        }
      @groups[group] ||= []
      @groups[group] << @images[name]
    end
  end
end

Imagify::App.new.run