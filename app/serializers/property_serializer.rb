class PropertySerializer < ActiveModel::Serializer
  attributes :id, :house_number, :offer_type, :property_type,
  :lng, :lat, :zip_code, :city, :street, :price
end
