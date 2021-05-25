# README

## Installation
- `gem install bundler`
- `bundle install`
- `rails db:create db:migrate`
- `brew install mongodb-community@4.4` (_macos_)
- `sudo apt install mongodb` (_linux_)
- `brew install redis-cli`

## Start
- `brew services start mongodb/brew/mongodb-community` (_macos_)
- `mongod --fork --logpath /var/log/mongod.log` (_linux_)
- `rails s`
- `redis-server`
- `sidekiq`

(or `bin/serv s`)

## Docker fast start (only linux)
- `docker-compose build && docker-compose up`
- `docker-compose run app rails db:create db:migrate`
