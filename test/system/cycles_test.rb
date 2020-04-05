require "application_system_test_case"

class CyclesTest < ApplicationSystemTestCase
  setup do
    @cycle = cycles(:one)
  end

  test "visiting the index" do
    visit cycles_url
    assert_selector "h1", text: "Cycles"
  end

  test "creating a Cycle" do
    visit cycles_url
    click_on "New Cycle"

    fill_in "Name", with: @cycle.name
    fill_in "Structure", with: @cycle.structure_id
    click_on "Create Cycle"

    assert_text "Cycle was successfully created"
    click_on "Back"
  end

  test "updating a Cycle" do
    visit cycles_url
    click_on "Edit", match: :first

    fill_in "Name", with: @cycle.name
    fill_in "Structure", with: @cycle.structure_id
    click_on "Update Cycle"

    assert_text "Cycle was successfully updated"
    click_on "Back"
  end

  test "destroying a Cycle" do
    visit cycles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cycle was successfully destroyed"
  end
end
