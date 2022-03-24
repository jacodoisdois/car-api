class User < ApplicationRecord
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true
  validates :nickname, uniqueness: true
  validates :password_digest, presence: true, allow_blank: false
  has_secure_password
end
