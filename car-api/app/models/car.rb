class Car < ApplicationRecord
  belongs_to :customer
  validates :model, length: { minimum: 1, maximum: 30 }, presence: true
  validates :brand, length: { minimum: 1, maximum: 30 }, presence: true
  validates :year, length: { minimum: 4, maximum: 4 }, presence: true
  validates :color, length: { minimum: 1, maximum: 20 }, presence: true
end
