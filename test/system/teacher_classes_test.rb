require "application_system_test_case"

class TeacherClassesTest < ApplicationSystemTestCase
  setup do
    @teacher_class = teacher_classes(:one)
  end

  test "visiting the index" do
    visit teacher_classes_url
    assert_selector "h1", text: "Teacher Classes"
  end

  test "creating a Teacher classe" do
    visit teacher_classes_url
    click_on "New Teacher Classe"

    fill_in "Salle de class", with: @teacher_class.salle_de_class_id
    fill_in "User", with: @teacher_class.user_id
    click_on "Create Teacher classe"

    assert_text "Teacher classe was successfully created"
    click_on "Back"
  end

  test "updating a Teacher classe" do
    visit teacher_classes_url
    click_on "Edit", match: :first

    fill_in "Salle de class", with: @teacher_class.salle_de_class_id
    fill_in "User", with: @teacher_class.user_id
    click_on "Update Teacher classe"

    assert_text "Teacher classe was successfully updated"
    click_on "Back"
  end

  test "destroying a Teacher classe" do
    visit teacher_classes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Teacher classe was successfully destroyed"
  end
end
