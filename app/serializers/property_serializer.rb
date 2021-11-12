class PropertySerializer < ActiveModel::Serializer
  attributes :id, :offer_type, :property_type, :zip_code, :city, :street, :house_number, :lng, :lat, :construction_year, :number_of_rooms, :currency, :price
end
