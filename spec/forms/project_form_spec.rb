# frozen_string_literal: true

require "spec_helper"

describe Decidim::Accountability::Admin::ProjectForm do
  let(:organization) { create(:organization, available_locales: [:en]) }
  let(:context) do
    {
      current_organization: organization,
      current_feature: current_feature
    }
  end
  let(:participatory_process) { create :participatory_process, organization: organization }
  let(:current_feature) { create :feature, participatory_process: participatory_process, manifest_name: "accountability" }

  let(:scope) { create :scope, organization: organization }
  let(:category) { create :category, participatory_process: participatory_process }
  let(:result) { create :accountability_result, feature: current_feature, scope: scope, category: category }

  let(:title) do
    Decidim::Faker::Localized.sentence(3)
  end
  let(:description) do
    Decidim::Faker::Localized.sentence(3)
  end
  let(:start_date) { Date.yesterday }
  let(:end_date) { Date.tomorrow }
  let(:status) { "ongoing" }
  let(:progress) { 89 }
  let(:external_id) { "ID_in_other_system" }

  let(:attributes) do
    {
      title_en: title[:en],
      description_en: description[:en],
      start_date: start_date,
      end_date: end_date,
      status: status,
      progress: progress,
      external_id: external_id
    }
  end

  subject { described_class.from_params(attributes).with_context(context) }

  it { is_expected.to be_valid }

  describe "when title is missing" do
    let(:title) { { en: nil } }

    it { is_expected.not_to be_valid }
  end

  describe "when description is missing" do
    let(:description) { { en: nil } }

    it { is_expected.not_to be_valid }
  end
end
