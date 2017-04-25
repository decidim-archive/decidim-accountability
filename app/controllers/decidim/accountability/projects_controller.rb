# frozen_string_literal: true

module Decidim
  module Accountability
    # Exposes the project resource so users can view them
    class ProjectsController < Decidim::Accountability::ApplicationController
      helper_method :project, :result, :progress_calculator, :current_scope

      private

      def project
        @project ||= Project.find(params[:id])
      end

      def result
        project.result
      end

      def context_params
        { feature: current_feature, organization: current_organization }
      end

      def progress_calculator(scope_id, category_id)
        Decidim::Accountability::ProgressCalculator.new(current_feature, scope_id, category_id).progress
      end

      def current_scope
        nil
      end
    end
  end
end
