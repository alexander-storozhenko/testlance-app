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

#Answer types

- `one,text`
- `one,img`
- `one,img-text`
- `some,text`
- `some,img`
- `some,img-text`
- `1to1,text`
- `1to1,img`(not supported)
- `1to1,img-text`(not supported)
- `1toN,text`(not supported)
- `1toN,img`(not supported)
- `1toN,img-text`(not supported)

#Answer formats
## One, Some
```json
[
  "answer 1 or img url", "[img url, answer text]",
  "answer 2 or img url", "[img url, answer text]",
  "answer 3 or img url", "[img url, answer text]"
]
```

## 1to1, 1toN
```json
{
    "up": {
        "A": "<block 1 or img url, [img url, block text]>",
        "B": "<block 1 or img url, [img url, block text]>",
        "C": "<block 1 or img url, [img url, block text]>"
    },
    "down":{
        "0": "<answer 1 or img url, [img url, answer text]>",
        "1": "<answer 1 or img url, [img url, answer text]>",
        "2": "<answer 1 or img url, [img url, answer text]>"
    }
}
```
---
*MIT license Copyright (c) 2021 Alexander Storozhenko*