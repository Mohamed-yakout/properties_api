module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filter_params)
      records = self
      filter_params.each do |field_name, value|
        records = records.send("filter_by_#{field_name}", value) if value.present?
      end
      records
    end
  end
end
