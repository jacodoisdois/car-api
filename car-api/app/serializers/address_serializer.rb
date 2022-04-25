class AddressSerializer
  include JSONAPI::Serializer
  belongs_to :customer
  attributes :address, :number, :district, :city, :state, :zip_code, :main_address
end
