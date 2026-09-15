class User < ApplicationRecord
  include AuthTokenManager

  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :tasks, dependent: :destroy
  has_one :auth_token, dependent: :destroy
end