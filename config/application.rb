require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThisOrThat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.generators do |g|
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    Raven.configure do |config|
      config.dsn = 'https://b7c07caecbbb4da58121f71ead8ad3b0:6906007b5e2c42eeb038b4908195b01f@sentry.io/1238818'
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
