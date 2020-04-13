require "application_system_test_case"

class CycleEcolesTest < ApplicationSystemTestCase
  setup do
    @cycle_ecole = cycle_ecoles(:one)
  end

  test "visiting the index" do
    visit cycle_ecoles_url
    assert_selector "h1", text: "Cycle Ecoles"
  end

  test "creating a Cycle ecole" do
    visit cycle_ecoles_url
    click_on "New Cycle Ecole"

    fill_in "Code", with: @cycle_ecole.code
    fill_in "Detail", with: @cycle_ecole.detail
    fill_in "Name", with: @cycle_ecole.name
    fill_in "Structure", with: @cycle_ecole.structure_id
    click_on "Create Cycle ecole"

    assert_text "Cycle ecole was successfully created"
    click_on "Back"
  end

  test "updating a Cycle ecole" do
    visit cycle_ecoles_url
    click_on "Edit", match: :first

    fill_in "Code", with: @cycle_ecole.code
    fill_in "Detail", with: @cycle_ecole.detail
    fill_in "Name", with: @cycle_ecole.name
    fill_in "Structure", with: @cycle_ecole.structure_id
    click_on "Update Cycle ecole"

    assert_text "Cycle ecole was successfully updated"
    click_on "Back"
  end

  test "destroying a Cycle ecole" do
    visit cycle_ecoles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cycle ecole was successfully destroyed"
  end
end
