class AccessToken < ApplicationRecord
  JWT_EXPIRE = 15.minutes.freeze
  RT_EXPIRE = 30.days.freeze

  class << self
    include Auth

    def refresh_jwt!(user_id)
      update! access_token_data

      encode_jwt({id: user_id})
    end

    def create_jwt!(user_id)
      create! access_token_data

      encode_jwt({id: user_id})
    end

    private

    def access_token_data
      time_now = DateTime.now

      {
          refresh_token: random_hash,
          rt_expires_at: time_now + RT_EXPIRE,
          jwt_expires_at: time_now + JWT_EXPIRE
      }
    end
  end
end
