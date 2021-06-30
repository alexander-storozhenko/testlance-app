class ProfileChange

  NICKNAME_KEY = 'profile_change_nickname_requests'.freeze

  def self.add_nickname_request(user_id, nickname)
    $redis.hset(NICKNAME_KEY, user_id, nickname)
  end
end
