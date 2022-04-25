class ProductSerializer
  include JSONAPI::Serializer
  attributes :title, :description, :price
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
