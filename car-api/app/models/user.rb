class User < ApplicationRecord
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true
  validates :nickname, uniqueness: true
  validates :password_digest, presence: true, allow_blank: false

  has_secure_password

  with_options if: :password do
    validates :password, presence: true, allow_blank: false,
                         format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%^&+=]).{8,}$\z/,
                                   message:
              'The password must have 8 characters, at least 1 ' \
              'uppercase, 1 lowercase, 1 number and 1 special character' }
  end

  scope :filter_by_name, lambda { |keyword|
                           where("(lower(description) LIKE '%#{keyword.downcase}%' or
                           lower(title) LIKE '%#{keyword.downcase}%') ")
                         }

  scope :recent, lambda { |order|
    order == 'true' ? order(created_at: :desc) : order(created_at: :asc)
  }

  def self.search(params = {})
    users = if params[:user_ids].present?
              User.find(params[:user_ids])
            else
              User.all
            end

    users = users.filter_by_name(params[:keyword]) if params[:keyword]
    users = users.recent(params[:recent]) if params[:recent].present?

    users
  end

  attr_reader :password

  def password=(raw)
    @password = raw
    self.password_digest = BCrypt::Password.create(raw)
  end
end
