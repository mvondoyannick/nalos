require "application_system_test_case"

class MatieresTest < ApplicationSystemTestCase
  setup do
    @matiere = matieres(:one)
  end

  test "visiting the index" do
    visit matieres_url
    assert_selector "h1", text: "Matieres"
  end

  test "creating a Matiere" do
    visit matieres_url
    click_on "New Matiere"

    fill_in "Descriptioin", with: @matiere.descriptioin
    fill_in "Filiere", with: @matiere.filiere_id
    fill_in "Name", with: @matiere.name
    click_on "Create Matiere"

    assert_text "Matiere was successfully created"
    click_on "Back"
  end

  test "updating a Matiere" do
    visit matieres_url
    click_on "Edit", match: :first

    fill_in "Descriptioin", with: @matiere.descriptioin
    fill_in "Filiere", with: @matiere.filiere_id
    fill_in "Name", with: @matiere.name
    click_on "Update Matiere"

    assert_text "Matiere was successfully updated"
    click_on "Back"
  end

  test "destroying a Matiere" do
    visit matieres_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Matiere was successfully destroyed"
  end
end
