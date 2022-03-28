class OrderService < ApplicationRecord
  belongs_to :order
  belongs_to :service, inverse_of: :order_services

  validates :service_duration, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 180 }
  validates :scheduled_time, presence: true
end
