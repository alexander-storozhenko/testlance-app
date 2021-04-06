class User < ApplicationRecord
  include BCrypt
  has_secure_password

  def generate_token
    update(oauth_token: SecureRandom.base64(64))
  end

  def authenticate!(password)
    result = try(:authenticate, password)
    raise 'Incorrect login or password' unless result

    result
  end
end
