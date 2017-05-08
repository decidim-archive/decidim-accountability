# frozen_string_literal: true

require "decidim/faker/localized"
require "decidim/dev"

FactoryGirl.define do
  factory :accountability_feature, parent: :feature do
    name { Decidim::Features::Namer.new(participatory_process.organization.available_locales, :accountability).i18n_name }
    manifest_name :accountability
    participatory_process { create(:participatory_process, :with_steps) }
  end

  factory :accountability_status, class: Decidim::Accountability::Status do
    feature { build(:feature, manifest_name: "accountability") }
    sequence(:key) { |n| "status_#{n}" }
    name { Decidim::Faker::Localized.word }
    description { Decidim::Faker::Localized.sentence(3) }
    progress { rand(1..100) }
  end

  factory :accountability_result, class: Decidim::Accountability::Result do
    feature { build(:feature, manifest_name: "accountability") }
    title { Decidim::Faker::Localized.sentence(3) }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    start_date { Date.yesterday }
    end_date { Date.tomorrow }
    status { create :accountability_status, feature: feature }
    progress { rand(1..100) }
  end
end
