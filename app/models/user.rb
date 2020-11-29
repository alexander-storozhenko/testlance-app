class User < ApplicationRecord
  validates :email, email: true
  validates :password, presence: true, length: { minimum: 8}
  validates :name, email: true, length: { minimum: 2 }
end
