require "application_system_test_case"

class LocalNewsTest < ApplicationSystemTestCase
  setup do
    @local_news = local_news(:one)
  end

  test "visiting the index" do
    visit local_news_url
    assert_selector "h1", text: "Local News"
  end

  test "creating a Local news" do
    visit local_news_url
    click_on "New Local News"

    fill_in "Extrait", with: @local_news.extrait
    fill_in "Statut", with: @local_news.statut
    fill_in "Title", with: @local_news.title
    click_on "Create Local news"

    assert_text "Local news was successfully created"
    click_on "Back"
  end

  test "updating a Local news" do
    visit local_news_url
    click_on "Edit", match: :first

    fill_in "Extrait", with: @local_news.extrait
    fill_in "Statut", with: @local_news.statut
    fill_in "Title", with: @local_news.title
    click_on "Update Local news"

    assert_text "Local news was successfully updated"
    click_on "Back"
  end

  test "destroying a Local news" do
    visit local_news_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Local news was successfully destroyed"
  end
end
