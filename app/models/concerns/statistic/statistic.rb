module Statistic
  class Statistic

    def self.delete(key)
      $redis.del(key)
    end

    def self.get_hash_all(key)
      $redis.hgetall(key).map{|k, v| [k.to_i, v.to_i]}.to_h
    end

    def self.increment_value_in_hash(key, hash_key)
      $redis.hincrby(key, hash_key, 1)
    end
  end
end

