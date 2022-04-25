class CustomerSerializer
  include JSONAPI::Serializer
  attributes :email, :addresses, :phone
  has_many :orders
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
