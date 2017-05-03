# frozen_string_literal: true

require "spec_helper"

describe Decidim::Accountability::Admin::UpdateProject do
  let(:result) { create :accountability_result }
  let(:project) { create :accountability_project, result: result }
  let(:organization) { result.feature.organization }
  let(:scope) { create :scope, organization: organization }
  let(:category) { create :category, participatory_process: result.feature.participatory_process }
  let(:participatory_process) { result.feature.participatory_process }

  let(:start_date) { Date.yesterday }
  let(:end_date) { Date.tomorrow }
  let(:status) { create :accountability_status, feature: result.feature, key: "finished", name: { en: "Finished" } }
  let(:progress) { 95 }
  let(:external_id) { "ID_in_other_system" }

  let(:form) do
    double(
      :invalid? => invalid,
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

  subject { described_class.new(form, project) }

  context "when the form is not valid" do
    let(:invalid) { true }

    it "is not valid" do
      expect { subject.call }.to broadcast(:invalid)
    end
  end

  context "when everything is ok" do
    it "updates the project" do
      subject.call
      expect(translated project.title).to eq "title"
      expect(translated project.status.name).to eq "Finished"
      expect(project.progress).to eq 95
    end
  end
end
