class User < ApplicationRecord
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    presence: true
  validates :nickname, uniqueness: true
  validates :password_digest, presence: true, allow_blank: false
  validates :password, presence: true, allow_blank: false,
                       format: { with: /(?=.*[!@#$%^&*])(?=.*[0-9])/,
                                 message: 'The password must have at least one special character and numbers' },
                       length: { minimum: 8, maximum: 100 }

  has_secure_password

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
end
