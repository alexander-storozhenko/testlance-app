threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

workers 2

port        ENV.fetch("PORT") { 3000 }

app_dir = File.expand_path("../..", __FILE__)
shared_dir = "#{app_dir}/shared"
bind "unix://#{shared_dir}/sockets/puma.sock"
environment ENV.fetch("RAILS_ENV") { "development" }
