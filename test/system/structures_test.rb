require "application_system_test_case"

class StructuresTest < ApplicationSystemTestCase
  setup do
    @structure = structures(:one)
  end

  test "visiting the index" do
    visit structures_url
    assert_selector "h1", text: "Structures"
  end

  test "creating a Structure" do
    visit structures_url
    click_on "New Structure"

    click_on "Create Structure"

    assert_text "Structure was successfully created"
    click_on "Back"
  end

  test "updating a Structure" do
    visit structures_url
    click_on "Edit", match: :first

    click_on "Update Structure"

    assert_text "Structure was successfully updated"
    click_on "Back"
  end

  test "destroying a Structure" do
    visit structures_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Structure was successfully destroyed"
  end
end
