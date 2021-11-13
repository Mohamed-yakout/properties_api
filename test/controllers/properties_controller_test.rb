require "test_helper"

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @property = properties(:one)
  end

  test "should get index" do
    get properties_url, as: :json
    assert_response :unprocessable_entity
  end

  test "should get index with location params" do
    get "#{properties_url}?lng=13.4236807&lat=52.5342963", as: :json
    assert_response :success
  end

  test "should get index with location and property_type filter" do
    get "#{properties_url}?lng=13.4236807&lat=52.5342963&property_type=apartment", as: :json
    assert_response :success
  end

  test "should get index with location and type filter" do
    get "#{properties_url}?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=sell", as: :json
    assert_response :success
  end

  test "should get index with wrong property_type filter" do
    get "#{properties_url}?lng=13.4236807&lat=52.5342963&property_type=apartment&marketing_type=AAA", as: :json
    assert_response :unprocessable_entity
  end

  test "should get index with wrong marketing_type filter" do
    get "#{properties_url}?lng=13.4236807&lat=52.5342963&property_type=AAA&marketing_type=sell", as: :json
    assert_response :unprocessable_entity
  end

  test "should get index with blank results" do
    get "#{properties_url}?lng=130.4236807&lat=5200.5342963&property_type=apartment&marketing_type=sell", as: :json
    assert_response :not_found
  end
end
