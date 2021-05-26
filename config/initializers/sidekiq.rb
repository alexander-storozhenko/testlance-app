Sidekiq.configure_server do |config|
  schedule_file = "config/schedule.yml"
  config.redis = {url: "redis://#{ENV['IP_ADDR']}:6379/0"}
  Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
end