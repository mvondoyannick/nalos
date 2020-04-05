require "application_system_test_case"

class SalleDeClassesTest < ApplicationSystemTestCase
  setup do
    @salle_de_class = salle_de_classes(:one)
  end

  test "visiting the index" do
    visit salle_de_classes_url
    assert_selector "h1", text: "Salle De Classes"
  end

  test "creating a Salle de class" do
    visit salle_de_classes_url
    click_on "New Salle De Class"

    fill_in "Cycle", with: @salle_de_class.cycle_id
    fill_in "Effectif", with: @salle_de_class.effectif
    fill_in "Name", with: @salle_de_class.name
    click_on "Create Salle de class"

    assert_text "Salle de class was successfully created"
    click_on "Back"
  end

  test "updating a Salle de class" do
    visit salle_de_classes_url
    click_on "Edit", match: :first

    fill_in "Cycle", with: @salle_de_class.cycle_id
    fill_in "Effectif", with: @salle_de_class.effectif
    fill_in "Name", with: @salle_de_class.name
    click_on "Update Salle de class"

    assert_text "Salle de class was successfully updated"
    click_on "Back"
  end

  test "destroying a Salle de class" do
    visit salle_de_classes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Salle de class was successfully destroyed"
  end
end
