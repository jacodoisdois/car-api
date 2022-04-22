class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :price
  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
