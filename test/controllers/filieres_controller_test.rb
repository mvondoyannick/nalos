require 'test_helper'

class FilieresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @filiere = filieres(:one)
  end

  test "should get index" do
    get filieres_url
    assert_response :success
  end

  test "should get new" do
    get new_filiere_url
    assert_response :success
  end

  test "should create filiere" do
    assert_difference('Filiere.count') do
      post filieres_url, params: { filiere: { content: @filiere.content, name: @filiere.name, salle_de_class_id: @filiere.salle_de_class_id } }
    end

    assert_redirected_to filiere_url(Filiere.last)
  end

  test "should show filiere" do
    get filiere_url(@filiere)
    assert_response :success
  end

  test "should get edit" do
    get edit_filiere_url(@filiere)
    assert_response :success
  end

  test "should update filiere" do
    patch filiere_url(@filiere), params: { filiere: { content: @filiere.content, name: @filiere.name, salle_de_class_id: @filiere.salle_de_class_id } }
    assert_redirected_to filiere_url(@filiere)
  end

  test "should destroy filiere" do
    assert_difference('Filiere.count', -1) do
      delete filiere_url(@filiere)
    end

    assert_redirected_to filieres_url
  end
end
