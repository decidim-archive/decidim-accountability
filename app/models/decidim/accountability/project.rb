# frozen_string_literal: true

module Decidim
  module Accountability
    # The data store for a Result in the Decidim::Accountability component. It stores a
    # title, description and any other useful information to render a custom result.
    class Project < Accountability::ApplicationRecord
      include Decidim::Resourceable
      include Decidim::HasFeature
      include Decidim::HasReference
      include Decidim::Comments::Commentable

      feature_manifest_name "accountability"

      VALID_STATUSES = ["planned", "ongoing", "finished"]

      belongs_to :result, foreign_key: "decidim_accountability_result_id", class_name: Decidim::Accountability::Result, inverse_of: :projects

      delegate :feature, :organization, :category, to: :result

      validates :start_date, presence: true
      validates :end_date, presence: true
      validates :progress, presence: true, numericality: true
      validates :status, presence: true, inclusion: { in: VALID_STATUSES }

      def parent_category
        category.try(:parent)
      end

      # Public: Overrides the `commentable?` Commentable concern method.
      def commentable?
        feature.settings.comments_enabled?
      end

      # Public: Overrides the `accepts_new_comments?` Commentable concern method.
      def accepts_new_comments?
        commentable? && !feature.active_step_settings.comments_blocked
      end

      # Public: Overrides the `comments_have_alignment?` Commentable concern method.
      def comments_have_alignment?
        true
      end

      # Public: Overrides the `comments_have_votes?` Commentable concern method.
      def comments_have_votes?
        true
      end
    end
  end
end
