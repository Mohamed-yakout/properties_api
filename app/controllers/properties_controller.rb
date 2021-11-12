class PropertiesController < ApplicationController
  # GET /properties
  def index
    @properties = Property.filter(property_filter_params).filter_by_location(location_filter_params)

    render json: @properties
  end

  private
    # location params is mandatory in filter
    def location_filter_params
      params.slice(:lat, :lng)
    end

    # other property attributes is optional
    def property_filter_params
      params.slice(:property_type, :marketing_type, :offer_type)
    end
end
