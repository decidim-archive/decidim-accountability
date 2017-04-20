# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This controller allows an admin to manage results from a Participatory Process
      class ProjectsController < Admin::ApplicationController
        helper_method :projects, :result

        def new
          @form = form(ProjectForm).instance
        end

        def create
          @form = form(ProjectForm).from_params(params)

          CreateProject.call(@form, result) do
            on(:ok) do
              flash[:notice] = I18n.t("projects.create.success", scope: "decidim.accountability.admin")
              redirect_to result_projects_path(result)
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("projects.create.invalid", scope: "decidim.accountability.admin")
              render action: "new"
            end
          end
        end

        def edit
          @form = form(ProjectForm).from_model(project)
        end

        def update
          @form = form(ProjectForm).from_params(params)

          UpdateProject.call(@form, project) do
            on(:ok) do
              flash[:notice] = I18n.t("projects.update.success", scope: "decidim.accountability.admin")
              redirect_to result_projects_path(result)
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("projects.update.invalid", scope: "decidim.accountability.admin")
              render action: "edit"
            end
          end
        end

        def destroy
          project.destroy!

          flash[:notice] = I18n.t("projects.destroy.success", scope: "decidim.accountability.admin")

          redirect_to result_projects_path
        end

        private

        def result
          @result ||= Result.where(feature: current_feature).find(params[:result_id])
        end

        def projects
          @projects ||= result.projects.page(params[:page]).per(15)
        end

        def project
          @project ||= projects.find(params[:id])
        end
      end
    end
  end
end
