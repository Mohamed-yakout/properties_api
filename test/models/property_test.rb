require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end


  test "the near scope in property" do
    properties = Property.near(52.5342963, 13.4236807)
    assert properties.count > 0
  end

  test "the filter_by_location scope return all near location less than 5KM" do
    location = {lat: 52.5342963, lng: 13.4236807}
    properties = Property.filter_by_location(location)
    distances = properties.map{|property| property.distance_to_location(location)}
    assert distances.all?{ |distance| distance <= Property::MAX_RADIUS_METERS }
  end

  test "the filter_by_property_type scope in property" do
    properties = Property.filter_by_property_type("apartment")
    assert properties.all?{|property| property.property_type == "apartment"}
  end

  test "the filter_by_marketing_type scope in property" do
    properties = Property.filter_by_marketing_type("sell")
    assert properties.all?{|property| property.offer_type == "sell"}
  end
end
