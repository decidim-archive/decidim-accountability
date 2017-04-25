# frozen_string_literal: true

module Decidim
  module Accountability
    # Custom helpers, scoped to the meetings engine.
    #
    module ApplicationHelper
      include PaginateHelper
      include Decidim::Comments::CommentsHelper

      def display_percentage(number)
        return unless number.present?

        "#{'%.02f' % number}%"
      end
    end
  end
end
