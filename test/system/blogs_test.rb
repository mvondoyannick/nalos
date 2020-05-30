require "application_system_test_case"

class BlogsTest < ApplicationSystemTestCase
  setup do
    @blog = blogs(:one)
  end

  test "visiting the index" do
    visit blogs_url
    assert_selector "h1", text: "Blogs"
  end

  test "creating a Blog" do
    visit blogs_url
    click_on "New Blog"

    fill_in "Categorie", with: @blog.categorie
    check "Student can read" if @blog.student_can_read
    fill_in "Title", with: @blog.title
    fill_in "User", with: @blog.user_id
    click_on "Create Blog"

    assert_text "Blog was successfully created"
    click_on "Back"
  end

  test "updating a Blog" do
    visit blogs_url
    click_on "Edit", match: :first

    fill_in "Categorie", with: @blog.categorie
    check "Student can read" if @blog.student_can_read
    fill_in "Title", with: @blog.title
    fill_in "User", with: @blog.user_id
    click_on "Update Blog"

    assert_text "Blog was successfully updated"
    click_on "Back"
  end

  test "destroying a Blog" do
    visit blogs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Blog was successfully destroyed"
  end
end
