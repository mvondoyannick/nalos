require 'test_helper'

class ProblemesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @probleme = problemes(:one)
  end

  test "should get index" do
    get problemes_url
    assert_response :success
  end

  test "should get new" do
    get new_probleme_url
    assert_response :success
  end

  test "should create probleme" do
    assert_difference('Probleme.count') do
      post problemes_url, params: { probleme: { title: @probleme.title } }
    end

    assert_redirected_to probleme_url(Probleme.last)
  end

  test "should show probleme" do
    get probleme_url(@probleme)
    assert_response :success
  end

  test "should get edit" do
    get edit_probleme_url(@probleme)
    assert_response :success
  end

  test "should update probleme" do
    patch probleme_url(@probleme), params: { probleme: { title: @probleme.title } }
    assert_redirected_to probleme_url(@probleme)
  end

  test "should destroy probleme" do
    assert_difference('Probleme.count', -1) do
      delete probleme_url(@probleme)
    end

    assert_redirected_to problemes_url
  end
end
