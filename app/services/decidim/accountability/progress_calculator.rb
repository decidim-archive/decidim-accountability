# frozen_string_literal: true

module Decidim
  module Accountability
    # This class handles the calculation of progress for a set of results
    class ProgressCalculator
      # Public: Initializes the service.
      # result - The result from which to calculate the stats.
      def initialize(feature, scope_id, category_id)
        @feature = feature
        @scope_id = scope_id
        @category_id = category_id
      end

      def progress
        results.average(:progress)
      end

      private

      attr_reader :feature, :scope_id, :category_id

      def results
        ResultSearch.new(feature: feature, scope_id: scope_id, category_id: category_id).results
      end
    end
  end
end
