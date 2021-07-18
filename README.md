# Readme

![testlance-logo-title](https://user-images.githubusercontent.com/54493133/126068961-266eebee-526e-4ace-b318-cef84b3e671d.png)

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

# Answer types

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

# Answer formats
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

# Lua scripts support
## Reason
Default test has simple count of right answers (one error in 1toN will be 0). User can create own logic of results calculating.
## Examples
### Default alghorithm of question (type 'one answer')
*in fact it counts inside ruby because of performance but I want to show principle of counting*
```lua
local result = 0

for key, _ in pairs(G_ALL_USER_ANSWERS) do
    if G_TRUE_ANSWERS[key] == 'true' then
        result = 1
    end
end

return result
```
### Limited question (user answer points will be decrease over time)
```lua
local result = 0

for key, _ in pairs(user_answers) do
    if true_answers[key] == 'true' then
        result = 1
    end
end

if G_DATE_NOW > to_date('05/08/2021') then
    return result/2
else
    if G_DATE_NOW > to_date('06/08/2021') then
        return result/3
    end
end

return result
```
*In the future, it will be possible to create your own profile variables and use from instead of inline values*

Examples was used global varibales (G_DATE_NOW, G_TRUE_ANSWERS, G_ALL_USER_ANSWERS) and helper functions (to_date). More about them in [testlance-parser](https://github.com/alexander-storozhenko/testlance-parser)

---
*MIT license Copyright (c) 2021 Alexander Storozhenko*
