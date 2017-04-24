# frozen_string_literal: true

class CreateAccountabilityProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :decidim_accountability_projects do |t|
      t.jsonb :title
      t.jsonb :description
      t.string :reference
      t.string :status
      t.date :start_date
      t.date :end_date
      t.integer :progress
      t.references :decidim_accountability_result, index: { name: :decidim_accountability_projects_on_result_id }
      t.string :external_id

      t.timestamps
    end
  end
end
