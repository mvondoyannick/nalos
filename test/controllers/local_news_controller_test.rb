require 'test_helper'

class LocalNewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @local_news = local_news(:one)
  end

  test "should get index" do
    get local_news_index_url
    assert_response :success
  end

  test "should get new" do
    get new_local_news_url
    assert_response :success
  end

  test "should create local_news" do
    assert_difference('LocalNews.count') do
      post local_news_index_url, params: { local_news: { extrait: @local_news.extrait, statut: @local_news.statut, title: @local_news.title } }
    end

    assert_redirected_to local_news_url(LocalNews.last)
  end

  test "should show local_news" do
    get local_news_url(@local_news)
    assert_response :success
  end

  test "should get edit" do
    get edit_local_news_url(@local_news)
    assert_response :success
  end

  test "should update local_news" do
    patch local_news_url(@local_news), params: { local_news: { extrait: @local_news.extrait, statut: @local_news.statut, title: @local_news.title } }
    assert_redirected_to local_news_url(@local_news)
  end

  test "should destroy local_news" do
    assert_difference('LocalNews.count', -1) do
      delete local_news_url(@local_news)
    end

    assert_redirected_to local_news_index_url
  end
end
