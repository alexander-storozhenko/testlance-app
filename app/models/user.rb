require 'auth'

class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  include Auth

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  after_create :set_default_avatar

  has_many :test_templates, dependent: :destroy
  has_many :mobile_devices, dependent: :destroy

  has_one_attached :avatar

  enum role: [:guest, :sub_admin, :admin]

  def avatar_url
    rails_blob_path(avatar, only_path: true)
  end

  def jwt
    encode_jwt({id: id})
  end

  def authenticate!(password)
    valid_password?(password)
  end

  def broadcast_push_notifications(data, one_for_all = true)
    return mobile_devices.each { |mobile| mobile.send_notification(data) } if one_for_all

    data.each_with_index { |notification, i| mobile_devices[i].send_notification(notification) }
  end

  private

  def set_default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default_avatar.jpeg")),
                    filename: 'default_avatar.jpeg',
                    content_type: "image/jpg")
    end
  end
end
