# frozen_string_literal: true

class AccountabilityAddProgressToResults < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_accountability_results, :progress, :decimal, precision: 5, scale: 2
  end
end
