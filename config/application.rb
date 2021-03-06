require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module GamePanel
  class Application < Rails::Application
    config.secret_key_base = ENV['SECRET_KEY_BASE']
    config.autoload_paths << Rails.root.join('app/null')
    config.action_mailer.default_url_options = { host: ENV['mailer_host'] }
  end
end
