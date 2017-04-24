# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Accountability
    describe Project do
      let(:project) { build :accountability_project }
      subject { project }

      it { is_expected.to be_valid }

      include_examples "has reference"

      it "is invalid when start_date is not present" do
        subject.start_date = nil
        expect(subject).to be_invalid
      end

      it "is invalid when end_date is not present" do
        subject.end_date = nil
        expect(subject).to be_invalid
      end

      it "is invalid when progress is not present" do
        subject.progress = nil
        expect(subject).to be_invalid
      end

      it "is invalid when progress is not a number" do
        subject.progress = "something"
        expect(subject).to be_invalid
      end

      it "is invalid when status is not present" do
        subject.status = nil
        expect(subject).to be_invalid
      end

      it "is invalid when status is not in the list of valid values" do
        subject.status = "invalid_value"
        expect(subject).to be_invalid
      end
    end
  end
end
