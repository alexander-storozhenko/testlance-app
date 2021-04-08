class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  before_save :ensure_authentication_token

  has_one_attached :avatar

  enum role: [:guest, :sub_admin, :admin]

  def avatar_url
    rails_blob_path(avatar , only_path: true)
  end

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end
  # User.create! email: 'lol2aaaa1dd3@lol', password: 'kekkekeke', role: 'guest'
  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  #include BCrypt
  #has_secure_password

  has_many :test_templates

  def generate_token
    update(oauth_token: SecureRandom.base64(64))
  end

  #def authenticate!(password)
  #  result = try(:authenticate, password)
  #  raise 'Incorrect login or password' unless result
  #
  #  result
  #end
  #
end
