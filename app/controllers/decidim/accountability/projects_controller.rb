# frozen_string_literal: true

module Decidim
  module Accountability
    # Exposes the project resource so users can view them
    class ProjectsController < Decidim::Accountability::ApplicationController
      helper_method :projects, :project

      private

      def projects
        @projects ||= Project.all.page(params[:page]).per(12)
      end

      def project
        @project ||= Project.find(params[:id])
      end

      def context_params
        { feature: current_feature, organization: current_organization }
      end
    end
  end
end
