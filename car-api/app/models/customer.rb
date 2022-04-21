class Customer < ApplicationRecord
  has_one :phone, dependent: :destroy
  has_many :cars, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :name, presence: true, length: { maximum: 150 }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true
  validates :birth_date, presence: true
  validates :social_security_number, length: { minimum: 10, maximum: 11 }

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :phone
  accepts_nested_attributes_for :cars, allow_destroy: true

  scope :filter_by_name, lambda { |keyword|
    where("(lower(name) LIKE '%#{keyword.downcase}%' or lower(email) LIKE '%#{keyword.downcase}%') ")
  }

  scope :recent, lambda { |_order|
    _order == 'true' ? order(created_at: :desc) : order(created_at: :asc)
  }

  def self.search(params = {})
    customers = if params[:customer_ids].present?
                  Customer.find(params[:customer_ids])
                else
                  Customer.all
                end

    customers = customers.filter_by_name(params[:keyword]) if params[:keyword]
    customers = customers.recent(params[:recent]) if params[:recent].present?

    customers
  end
end
