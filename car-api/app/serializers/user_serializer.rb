class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :nickname, :email
end
