# frozen_string_literal: true

module Decidim
  module Accountability
    # Custom helpers, scoped to the meetings engine.
    #
    module ApplicationHelper
      include PaginateHelper
      include Decidim::Comments::CommentsHelper
    end
  end
end
