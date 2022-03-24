class Address < ApplicationRecord
  belongs_to :customer
  validates :number, presence: true, length: { minimum: 1, maximum: 5 }
  validates :district, presence: true, length: { minimum: 0 }
end
