require "application_system_test_case"

class EnseignementsTest < ApplicationSystemTestCase
  setup do
    @enseignement = enseignements(:one)
  end

  test "visiting the index" do
    visit enseignements_url
    assert_selector "h1", text: "Enseignements"
  end

  test "creating a Enseignement" do
    visit enseignements_url
    click_on "New Enseignement"

    fill_in "Content", with: @enseignement.content
    fill_in "Title", with: @enseignement.title
    click_on "Create Enseignement"

    assert_text "Enseignement was successfully created"
    click_on "Back"
  end

  test "updating a Enseignement" do
    visit enseignements_url
    click_on "Edit", match: :first

    fill_in "Content", with: @enseignement.content
    fill_in "Title", with: @enseignement.title
    click_on "Update Enseignement"

    assert_text "Enseignement was successfully updated"
    click_on "Back"
  end

  test "destroying a Enseignement" do
    visit enseignements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Enseignement was successfully destroyed"
  end
end
