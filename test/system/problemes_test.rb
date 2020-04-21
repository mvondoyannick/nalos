require "application_system_test_case"

class ProblemesTest < ApplicationSystemTestCase
  setup do
    @probleme = problemes(:one)
  end

  test "visiting the index" do
    visit problemes_url
    assert_selector "h1", text: "Problemes"
  end

  test "creating a Probleme" do
    visit problemes_url
    click_on "New Probleme"

    fill_in "Title", with: @probleme.title
    click_on "Create Probleme"

    assert_text "Probleme was successfully created"
    click_on "Back"
  end

  test "updating a Probleme" do
    visit problemes_url
    click_on "Edit", match: :first

    fill_in "Title", with: @probleme.title
    click_on "Update Probleme"

    assert_text "Probleme was successfully updated"
    click_on "Back"
  end

  test "destroying a Probleme" do
    visit problemes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Probleme was successfully destroyed"
  end
end
