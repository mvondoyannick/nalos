require "application_system_test_case"

class ClasseMatieresTest < ApplicationSystemTestCase
  setup do
    @classe_matiere = classe_matieres(:one)
  end

  test "visiting the index" do
    visit classe_matieres_url
    assert_selector "h1", text: "Classe Matieres"
  end

  test "creating a Classe matiere" do
    visit classe_matieres_url
    click_on "New Classe Matiere"

    fill_in "Matiere", with: @classe_matiere.matiere_id
    fill_in "Salle de class", with: @classe_matiere.salle_de_class_id
    click_on "Create Classe matiere"

    assert_text "Classe matiere was successfully created"
    click_on "Back"
  end

  test "updating a Classe matiere" do
    visit classe_matieres_url
    click_on "Edit", match: :first

    fill_in "Matiere", with: @classe_matiere.matiere_id
    fill_in "Salle de class", with: @classe_matiere.salle_de_class_id
    click_on "Update Classe matiere"

    assert_text "Classe matiere was successfully updated"
    click_on "Back"
  end

  test "destroying a Classe matiere" do
    visit classe_matieres_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Classe matiere was successfully destroyed"
  end
end
