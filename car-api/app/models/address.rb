class Address < ApplicationRecord
  belongs_to :customer
  validates :address, presence: true, length: { minimum: 3, maximum: 100 }
  validates :number, presence: true, length: { minimum: 1, maximum: 5 },
                     format: { with: /\A\d+\z/, message: 'Only numbers allowed' }
  validates :district, presence: true, length: { mininum: '4', maximum: 40 }
  validates :city, presence: true, length: { minimum: 1, maximum: 50 }
  validates :state, presence: true, length: { minimum: 2, maximum: 2 }
  validates :address_line_two, length: { maximum: 100 }
  validates :zip_code, presence: true, length: { minimum: 8, maximum: 10 },
                       format: { with: /\A\d+\z/, message: 'Only numbers allowed' }
end
