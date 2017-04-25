# frozen_string_literal: true

require "searchlight"
require "kaminari"

module Decidim
  module Accountability
    # This is the engine that runs on the public interface of `decidim-accountability`.
    # It mostly handles rendering the created results associated to a participatory
    # process.
    class ListEngine < ::Rails::Engine
      isolate_namespace Decidim::Accountability

      routes do
        resources :results, only: [:index, :show] do
          resources :projects, only: [:show], shallow: true
        end
        root to: "results#home"
      end
    end
  end
end
