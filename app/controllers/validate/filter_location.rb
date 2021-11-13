module Validate
  class FilterLocation
    include ActiveModel::Validations

    attr_accessor :latitude, :longitude

    validates :latitude, presence: true, numericality: true
    validates :longitude, presence: true, numericality: true


    def initialize(params={})
      @latitude = params[:lat]
      @longitude = params[:lng]
    end
  end
end
