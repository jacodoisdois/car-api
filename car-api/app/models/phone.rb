class Phone < ApplicationRecord
  belongs_to :customer
  validates :country_code, length: { minimum: 1, maximum: 3 },
                           format: { with: /\A\d+\z/, message: 'Only numbers allowed in country code field' }
  validates :local_code, length: { minimum: 1, maximum: 3 },
                         format: { with: /\A\d+\z/, message: 'Only numbers allowed in DDD field' }
  validates :number, length: { minimum: 9, maximum: 9 },
                     format: { with: /\A\d+\z/, message: 'Only numbers allowed in phone number field' }
end
