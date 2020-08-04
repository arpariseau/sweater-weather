class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, on: create
  validates :password_confirmation, presence: true

  has_secure_password

  def generate_api_key
    update(api_key: SecureRandom.uuid)
  end
end
