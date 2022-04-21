class AddressSerializer
  include JSONAPI::Serializer
  attributes :address, :number, :district, :city, :state, :zip_code, :main_address
end
