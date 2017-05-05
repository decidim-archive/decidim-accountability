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

      def active_class_if_current(scope)
        %Q{class=active} if scope.to_s == current_scope.to_s
      end
    end
  end
end
