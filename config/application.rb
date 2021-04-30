require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TestsAppApi
  class Application < Rails::Application
    $redis = Redis.new(host: '127.0.0.1', port: 6379, db: 15)
  end
end
