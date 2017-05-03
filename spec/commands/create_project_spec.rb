# frozen_string_literal: true

require "spec_helper"

describe Decidim::Accountability::Admin::CreateProject do
  let(:organization) { create :organization, available_locales: [:en] }
  let(:participatory_process) { create :participatory_process, organization: organization }
  let(:current_feature) { create :feature, manifest_name: "accountability", participatory_process: participatory_process }
  let(:scope) { create :scope, organization: organization }
  let(:category) { create :category, participatory_process: participatory_process }
  let(:result) { create :accountability_result, feature: current_feature, scope: scope, category: category }

  let(:start_date) { Date.yesterday }
  let(:end_date) { Date.tomorrow }
  let(:status) { create :accountability_status, feature: current_feature, key: "ongoing", name: { en: "Ongoing" } }
  let(:progress) { 89 }
  let(:external_id) { "ID_in_other_system" }

  let(:form) do
    double(
      :invalid? => invalid,
      result: result,
      title: { en: "title" },
      description: { en: "description" },
      start_date: start_date,
      end_date: end_date,
      decidim_accountability_status_id: status.id,
      progress: progress,
      external_id: external_id
    )
  end
  let(:invalid) { false }

  subject { described_class.new(form, result) }

  context "when the form is not valid" do
    let(:invalid) { true }

    it "is not valid" do
      expect { subject.call }.to broadcast(:invalid)
    end
  end

  context "when everything is ok" do
    let(:project) { Decidim::Accountability::Project.last }

    it "creates the project" do
      expect { subject.call }.to change { Decidim::Accountability::Project.count }.by(1)
    end

    it "sets the result" do
      subject.call
      expect(project.result).to eq result
    end

  end
end
