require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ProjectDark
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'localhost:3001'
        resource '*', headers: :any, methods: [:get, :post, :options]
      end
    end
  end
end
