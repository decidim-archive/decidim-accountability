# frozen_string_literal: true

require "spec_helper"

describe "Process admin manages results", type: :feature do
  include_context "admin"
  let(:user) { process_admin }
  it_behaves_like "manage results"

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.manage_feature_path(participatory_process_id: participatory_process, feature_id: current_feature)
  end
end

describe "Process admin manages child results", type: :feature do
  include_context "admin"
  let(:user) { process_admin }
  it_behaves_like "manage child results"

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.manage_feature_path(participatory_process_id: participatory_process, feature_id: current_feature)
    click_link translated(result.title)
  end
end

describe "Process admin manages statuses", type: :feature do
  include_context "admin"
  let(:user) { process_admin }
  it_behaves_like "manage statuses"

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
    visit decidim_admin.manage_feature_path(participatory_process_id: participatory_process, feature_id: current_feature)
    click_link "Statuses"
  end
end
