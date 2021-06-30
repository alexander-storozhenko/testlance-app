class AccessToken < ApplicationRecord
  include Auth

  JWT_EXPIRE = 15.minutes
  RT_EXPIRE = 30.days

  def new_jwt
    jwt = encode_jwt({id: user.id})

    time_now = DateTime.utc.now

    update! refresh_token: random_hash,
            rt_expires_at: time_now + RT_EXPIRE,
            jwt_expires_at: time_now + JWT_EXPIRE

    jwt
  end
end
