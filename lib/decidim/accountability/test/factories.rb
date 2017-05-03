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
    sequence(:key) { |n| "status_#{n}" }
    name { Decidim::Faker::Localized.word }
    feature { build(:feature, manifest_name: "accountability") }
  end

  factory :accountability_result, class: Decidim::Accountability::Result do
    title { Decidim::Faker::Localized.sentence(3) }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    feature { build(:feature, manifest_name: "accountability") }
  end

  factory :accountability_project, class: Decidim::Accountability::Project do
    result { create :accountability_result }
    title { Decidim::Faker::Localized.sentence(3) }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { Decidim::Faker::Localized.sentence(4) } }
    start_date { Date.yesterday }
    end_date { Date.tomorrow }
    status { create :accountability_status, feature: result.feature }
    progress { rand(1..100) }
  end
end
