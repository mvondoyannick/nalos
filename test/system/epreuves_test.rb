require "application_system_test_case"

class EpreuvesTest < ApplicationSystemTestCase
  setup do
    @epreufe = epreuves(:one)
  end

  test "visiting the index" do
    visit epreuves_url
    assert_selector "h1", text: "Epreuves"
  end

  test "creating a Epreuve" do
    visit epreuves_url
    click_on "New Epreuve"

    fill_in "Matiere", with: @epreufe.matiere_id
    fill_in "Salle de class", with: @epreufe.salle_de_class_id
    fill_in "Title", with: @epreufe.title
    fill_in "User", with: @epreufe.user_id
    click_on "Create Epreuve"

    assert_text "Epreuve was successfully created"
    click_on "Back"
  end

  test "updating a Epreuve" do
    visit epreuves_url
    click_on "Edit", match: :first

    fill_in "Matiere", with: @epreufe.matiere_id
    fill_in "Salle de class", with: @epreufe.salle_de_class_id
    fill_in "Title", with: @epreufe.title
    fill_in "User", with: @epreufe.user_id
    click_on "Update Epreuve"

    assert_text "Epreuve was successfully updated"
    click_on "Back"
  end

  test "destroying a Epreuve" do
    visit epreuves_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Epreuve was successfully destroyed"
  end
end
