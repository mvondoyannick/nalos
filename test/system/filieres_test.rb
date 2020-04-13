require "application_system_test_case"

class FilieresTest < ApplicationSystemTestCase
  setup do
    @filiere = filieres(:one)
  end

  test "visiting the index" do
    visit filieres_url
    assert_selector "h1", text: "Filieres"
  end

  test "creating a Filiere" do
    visit filieres_url
    click_on "New Filiere"

    fill_in "Content", with: @filiere.content
    fill_in "Name", with: @filiere.name
    fill_in "Salle de class", with: @filiere.salle_de_class_id
    click_on "Create Filiere"

    assert_text "Filiere was successfully created"
    click_on "Back"
  end

  test "updating a Filiere" do
    visit filieres_url
    click_on "Edit", match: :first

    fill_in "Content", with: @filiere.content
    fill_in "Name", with: @filiere.name
    fill_in "Salle de class", with: @filiere.salle_de_class_id
    click_on "Update Filiere"

    assert_text "Filiere was successfully updated"
    click_on "Back"
  end

  test "destroying a Filiere" do
    visit filieres_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Filiere was successfully destroyed"
  end
end
