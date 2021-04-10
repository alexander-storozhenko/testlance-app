class User < ApplicationRecord
  include Rails.application.routes.url_helpers

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  before_save :ensure_authentication_token
  after_create :set_default_avatar

  has_many :test_templates
  has_one_attached :avatar

  enum role: [:guest, :sub_admin, :admin]

  def avatar_url
    rails_blob_path(avatar, only_path: true)
  end

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def set_default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_avatar.jpeg")),
                    filename: 'default_avatar.jpeg',
                    content_type: "image/jpg")
    end
  end
end
