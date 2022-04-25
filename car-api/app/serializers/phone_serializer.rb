class PhoneSerializer
  include JSONAPI::Serializer
  belongs_to :customer
  attributes :country_code, :local_code, :number
end
