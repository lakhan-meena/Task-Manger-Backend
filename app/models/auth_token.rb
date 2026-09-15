class AuthToken < ApplicationRecord

  # Associations
  belongs_to :user

  # Validations
  validates :access_token, presence: true, uniqueness: true
  validates :refresh_token, presence: true, uniqueness: true
end
