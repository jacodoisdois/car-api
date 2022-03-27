class Service < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :price, presence: true, numericality: { greater_than: 0, less_than: 10_000_000 }
  validates :description, presence: true, length: { minimum: 10, maximum: 400 }
  validates :duration, presence: true, length: { minimum: 1, maximum: 3 }
end
