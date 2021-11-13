module Validate
  class FilterParams
    include ActiveModel::Validations

    attr_accessor :search_params

    FILTER_PARAMS_KEYS = %w(lat lng property_type marketing_type offer_type action controller page property)

    validate :valid_search_params


    def initialize(params={})
      @search_params = params
    end

    def valid_search_params
      # puts @search_params.keys
      puts @search_params.keys - FILTER_PARAMS_KEYS

      unless (@search_params.keys - FILTER_PARAMS_KEYS).blank?
        self.errors.add(:base, "some extra keys in search url")
      end
    end
  end
end
