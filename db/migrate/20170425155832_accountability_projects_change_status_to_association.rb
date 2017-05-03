# frozen_string_literal: true

class AccountabilityProjectsChangeStatusToAssociation < ActiveRecord::Migration[5.0]
  def change
    remove_column :decidim_accountability_projects, :status
    add_column :decidim_accountability_projects, :decidim_accountability_status_id, :integer
  end
end
