module Validate
  class FilterType
    include ActiveModel::Validations

    attr_accessor :marketing_type, :offer_type, :property_type

    validates :marketing_type, inclusion: { in: ['rent', 'sell'] }, allow_nil: true
    validates :offer_type, inclusion: { in: ['rent', 'sell'] }, allow_nil: true
    validates :property_type, inclusion: { in: ['apartment', 'single_family_house'] }, allow_nil: true

    def initialize(params={})
      @marketing_type = params[:marketing_type]
      @offer_type = params[:offer_type]
      @property_type = params[:property_type]
    end
  end
end
