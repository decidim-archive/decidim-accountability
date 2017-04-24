# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This command is executed when the user creates a Project from the admin
      # panel.
      class CreateProject < Rectify::Command
        def initialize(form, result)
          @form = form
          @result = result
        end

        # Creates the project if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if @form.invalid?

          transaction do
            create_project
          end

          broadcast(:ok)
        end

        private

        attr_reader :project, :result

        def create_project
          @project = result.projects.create!(
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
