class User < ApplicationRecord
  include BCrypt
  has_secure_password

  has_many :test_templates

  def generate_token
    update(oauth_token: SecureRandom.base64(64))
  end

  def authenticate!(password)
    result = try(:authenticate, password)
    raise 'Incorrect login or password' unless result

    result
  end
end
