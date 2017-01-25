require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module GamePanel
  class Application < Rails::Application
    config.secret_key_base = ENV['SECRET_KEY_BASE']
  end
end
