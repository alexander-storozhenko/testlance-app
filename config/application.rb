require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module TestsAppApi
  class Application < Rails::Application
    $redis = Redis.new(host: ENV['REDIS_ADDR'], port: ENV['REDIS_PORT'], db: 15)
  end
end
