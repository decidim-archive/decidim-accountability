# frozen_string_literal: true

require_dependency "decidim/features/namer"

Decidim.register_feature(:accountability) do |feature|
  feature.engine = Decidim::Accountability::ListEngine
  feature.admin_engine = Decidim::Accountability::AdminEngine
  feature.icon = "decidim/accountability/icon.svg"

  feature.on(:before_destroy) do |instance|
    raise StandardError, "Can't remove this feature" if Decidim::Accountability::Result.where(feature: instance).any?
  end

  feature.register_resource do |resource|
    resource.model_class_name = "Decidim::Accountability::Result"
    resource.template = "decidim/accountability/results/linked_results"
  end

  feature.settings(:global) do |settings|
    settings.attribute :comments_enabled, type: :boolean, default: true
  end

  feature.settings(:step) do |settings|
    settings.attribute :comments_blocked, type: :boolean, default: false
  end

  feature.seeds do
    Decidim::ParticipatoryProcess.all.each do |process|
      next unless process.steps.any?

      feature = Decidim::Feature.create!(
        name: Decidim::Features::Namer.new(process.organization.available_locales, :accountability).i18n_name,
        manifest_name: :accountability,
        published_at: Time.current,
        participatory_process: process
      )

      3.times do
        result = Decidim::Accountability::Result.create!(
          feature: feature,
          scope: process.organization.scopes.sample,
          category: process.categories.sample,
          title: Decidim::Faker::Localized.sentence(2),
          description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
            Decidim::Faker::Localized.paragraph(3)
          end
        )

        Decidim::Comments::Seed.comments_for(result)

        3.times do
          project = Decidim::Accountability::Project.create!(
            result: result,
            start_date: Date.today,
            end_date: Date.today + 10,
            status: Decidim::Accountability::Project::VALID_STATUSES.sample,
            progress: rand(1..100),
            title: Decidim::Faker::Localized.sentence(2),
            description: Decidim::Faker::Localized.wrapped("<p>", "</p>") do
              Decidim::Faker::Localized.paragraph(3)
            end
          )

          Decidim::Comments::Seed.comments_for(project)
        end
      end
    end
  end
end
