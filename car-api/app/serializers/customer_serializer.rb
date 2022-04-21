class CustomerSerializer
  include JSONAPI::Serializer
  has_many :orders

  attributes :email, :addresses, :phone
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
