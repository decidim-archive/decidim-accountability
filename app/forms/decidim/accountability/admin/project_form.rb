# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This class holds a Form to create/update results from Decidim's admin panel.
      class ProjectForm < Decidim::Form
        include TranslatableAttributes
        include TranslationsHelper

        translatable_attribute :title, String
        translatable_attribute :description, String
        attribute :start_date, Date
        attribute :end_date, Date
        attribute :decidim_accountability_status_id, Integer
        attribute :progress, Integer
        attribute :external_id, String

        validates :title, translatable_presence: true
        validates :description, translatable_presence: true

        validates :start_date, presence: true
        validates :end_date, presence: true
        validates :progress, presence: true
        validates :decidim_accountability_status_id, presence: true
      end
    end
  end
end
