# frozen_string_literal: true

module Decidim
  module Accountability
    # The data store for a Result in the Decidim::Accountability component. It stores a
    # title, description and any other useful information to render a custom result.
    class Status < Accountability::ApplicationRecord
      include Decidim::HasFeature

      feature_manifest_name "accountability"

      has_many :results, foreign_key: "decidim_accountability_status_id", class_name: Decidim::Accountability::Result, inverse_of: :status

      validates :key, presence: true, uniqueness: { scope: :decidim_feature_id }
      validates :name, presence: true
    end
  end
end
