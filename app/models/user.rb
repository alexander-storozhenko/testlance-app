class User < ApplicationRecord
  # include Mongoid::Document
  # include Mongoid::Attributes::Dynamic
  #
  # field :email,              type: String, default: ""
  # field :encrypted_password, type: String, default: ""
  #
  # field :reset_password_token,   type: String
  # field :reset_password_sent_at, type: Time
  #
  # field :authentication_token, type: String
  #
  # field :remember_created_at, type: Time
  #
  # field :tests, type: Array
  #
  # field :recommend_ids, type: Array
  #
  # field :experience, type: Integer, default: 0

  # validates :email, uniqueness: true

  def generate_token!
    self.authentication_token = SecureRandom.urlsafe_base64
    return generate_token if User.find_by(authentication_token: self.authentication_token)
    save!
  end
end
