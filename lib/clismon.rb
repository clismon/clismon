$:.unshift File.dirname(__FILE__)     # For use/testing when no gem is installed

# rubygems
require 'rubygems'

# core
require 'fileutils'
require 'time'
require 'yaml'

# stdlib

# 3rd party
require 'image_size'

# internal requires
require 'clismon/site'
require 'clismon/context'
require 'clismon/builder'
require 'clismon/bloc'
require 'clismon/renders'

module Clismon

  class Site
    def initialize(options)
      @options = options
    end

    def build
      base = File.join('.', 'source')
      entries = []
      Dir.chdir(base) { entries = Dir['**/*.page.rb'] }
      entries.each do |name|
        ctx = Context.new(File.join('.', 'source'), name)
        ctx.output = File.join('.', 'output')
        page = eval(ctx.read_source)
        builder = Builder.new
        page.render(builder, ctx)
        puts builder
      end
    end
  end
end

Clismon::Site.new({}).build
