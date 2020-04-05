require 'test_helper'

class EnseignementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @enseignement = enseignements(:one)
  end

  test "should get index" do
    get enseignements_url
    assert_response :success
  end

  test "should get new" do
    get new_enseignement_url
    assert_response :success
  end

  test "should create enseignement" do
    assert_difference('Enseignement.count') do
      post enseignements_url, params: { enseignement: { content: @enseignement.content, title: @enseignement.title } }
    end

    assert_redirected_to enseignement_url(Enseignement.last)
  end

  test "should show enseignement" do
    get enseignement_url(@enseignement)
    assert_response :success
  end

  test "should get edit" do
    get edit_enseignement_url(@enseignement)
    assert_response :success
  end

  test "should update enseignement" do
    patch enseignement_url(@enseignement), params: { enseignement: { content: @enseignement.content, title: @enseignement.title } }
    assert_redirected_to enseignement_url(@enseignement)
  end

  test "should destroy enseignement" do
    assert_difference('Enseignement.count', -1) do
      delete enseignement_url(@enseignement)
    end

    assert_redirected_to enseignements_url
  end
end
