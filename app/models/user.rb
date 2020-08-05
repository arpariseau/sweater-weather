class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  has_secure_password

  def generate_api_key
    update(api_key: SecureRandom.uuid)
  end
end
