class OrderSerializer
  include JSONAPI::Serializer
  belongs_to :customer
  has_many :products
  attributes :total, :products
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
