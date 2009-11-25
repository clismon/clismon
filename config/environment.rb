# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

  config.gem 'inherited_resources', :source => 'http://gemcutter.org'
  config.gem 'paperclip', :source => 'http://gemcutter.org'

  config.action_controller.resources_path_names = { :new => 'nuevo', :edit => 'cambiar' }

  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :es
end
