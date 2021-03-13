require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestsAppApi
  class Application < Rails::Application
    config.generators do |g|
      g.orm :mongoid
    end
    Mongoid.logger       = Logger.new('mongoid.log')
    Mongoid.logger.level = Logger::INFO
    # config.mongoid.logger = Logger.new(Rails.root + '/log/mongoid.log', :warn)
    Mongo::Logger.logger.level = Logger::FATAL
    config.web_console.whitelisted_ips = '192.168.0.10'
    # Mongo::Client.new("mongodb://127.0.0.1:27017/tests_app_api")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
