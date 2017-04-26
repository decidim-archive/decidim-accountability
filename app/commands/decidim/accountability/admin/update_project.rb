# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This command is executed when the user changes a Project from the admin
      # panel.
      class UpdateProject < Rectify::Command
        # Initializes an UpdateProject Command.
        #
        # form - The form from which to get the data.
        # project - The current instance of the project to be updated.
        def initialize(form, project)
          @form = form
          @project = project
        end

        # Updates the project if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if form.invalid?

          transaction do
            update_project
          end

          broadcast(:ok)
        end

        private

        attr_reader :project, :form

        def update_project
          project.update_attributes!(
            title: @form.title,
            description: @form.description,
            start_date: @form.start_date,
            end_date: @form.end_date,
            status: @form.status,
            progress: @form.progress
          )
        end
      end
    end
  end
end
