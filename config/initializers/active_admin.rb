ActiveAdmin.setup do |config|
  # == Site Title
  config.site_title = "Game Panel"

  # == Default Namespace
  config.default_namespace = :manager

  # == Root
  config.root_to = 'users#index'

  # == Admin Comments
  # You can completely disable comments:
  config.comments = false


  # == Batch Actions
  # Enable and disable Batch Actions
  config.batch_actions = true

  # == Localize Date/Time Format
  config.localize_format = :long

  # To disable/customize for the :admin namespace:
    config.namespace :manager do |admin|
      # Disable the links entirely
        admin.download_links = false
    end

  # == Pagination
  config.default_per_page = 30

  # == Footer
  config.footer = 'http://geekhub.ck.ua/courses/#ruby-on-rails'

  config.before_filter :authenticate_admin_user!
end
