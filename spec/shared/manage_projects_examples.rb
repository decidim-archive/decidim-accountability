# -*- coding: utf-8 -*-
# frozen_string_literal: true

RSpec.shared_examples "manage projects" do
  it "updates a project" do
    within find("tr", text: translated(project.title)) do
      find("a.action-icon--edit").click
    end

    within ".edit_project" do
      fill_in_i18n(
        :project_title,
        "#title-tabs",
        en: "My new title",
        es: "Mi nuevo título",
        ca: "El meu nou títol"
      )

      find("*[type=submit]").click
    end

    within ".callout-wrapper" do
      expect(page).to have_content("successfully")
    end

    within "table" do
      expect(page).to have_content("My new title")
    end
  end

  context "previewing projects" do
    it "allows the user to preview the project" do
      within find("tr", text: translated(project.title)) do
        @new_window = window_opened_by { find("a.action-icon--preview").click }
      end

      within_window @new_window do
        expect(current_path).to eq decidim_accountability.project_path(id: project.id, participatory_process_id: participatory_process.id, feature_id: current_feature.id)
        expect(page).to have_content(translated(project.title))
      end
    end
  end

  it "creates a new project" do
    click_link "New Project"

    within ".new_project" do
      fill_in_i18n(
        :project_title,
        "#title-tabs",
        en: "My project",
        es: "Mi project",
        ca: "El meu project"
      )
      fill_in_i18n_editor(
        :project_description,
        "#description-tabs",
        en: "A longer description",
        es: "Descripción más larga",
        ca: "Descripció més llarga"
      )

      page.execute_script("$('#project_start_date').val('20/04/2017')")
      page.execute_script("$('#project_end_date').val('20/04/2017')")
      select "Ongoing", from: :project_decidim_accountability_status_id
      fill_in :project_progress, with: 89
      fill_in :project_external_id, with: "ID_in_other_system"

      find("*[type=submit]").click
    end

    within ".callout-wrapper" do
      expect(page).to have_content("successfully")
    end

    within "table" do
      expect(page).to have_content("My project")
    end
  end

  context "deleting a project" do
    let!(:project2) { create(:accountability_project, result: result) }

    before do
      visit current_path
    end

    it "deletes a project" do
      within find("tr", text: translated(project2.title)) do
        find("a.action-icon--remove").click
      end

      within ".callout-wrapper" do
        expect(page).to have_content("successfully")
      end

      within "table" do
        expect(page).not_to have_content(translated(project2.title))
      end
    end
  end
end
