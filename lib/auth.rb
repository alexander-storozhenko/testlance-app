require 'jwt'

module Auth
  ALG = 'HS256'
  HMAC_SECRET = ENV['HMAC_SECRET']

  def encode_jwt(payload)
    JWT.encode payload, HMAC_SECRET, ALG
  end

  def decode_jwt(token)
    JWT.decode token, HMAC_SECRET, true, ALG
  rescue
    nil
  end
end
