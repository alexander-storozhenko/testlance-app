module Statistic
  class UserTestStatistic

    HASH_KEY = 'test_views_statistic'.freeze

    def self.delete_hash
      $redis.del(HASH_KEY)
    end

    def self.hash
      $redis.hgetall(HASH_KEY).map{|k, v| [k.to_i, v.to_i]}.to_h
    end

    def self.increment_test_t_plays(test_t_id)
      $redis.hincrby(HASH_KEY, test_t_id, 1)
    end
  end
end
