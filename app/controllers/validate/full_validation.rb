module Validate
  class FullValidation
    include ActiveModel::Validations

    attr_accessor :filters

    validate :valid_filters


    def initialize(params={})
      @filters = [
        FilterParams.new(params),
        FilterLocation.new(params),
        FilterType.new(params)
      ]
    end

    def valid_filters
      errors = {}
      @filters.each do |filter|
        unless filter.valid?
          errors[filter.class.to_s] = filter.errors
        end
      end

      unless errors.blank?
        self.errors.add(:base, errors)
      end
    end
  end
end
