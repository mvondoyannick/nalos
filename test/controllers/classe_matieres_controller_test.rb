require 'test_helper'

class ClasseMatieresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @classe_matiere = classe_matieres(:one)
  end

  test "should get index" do
    get classe_matieres_url
    assert_response :success
  end

  test "should get new" do
    get new_classe_matiere_url
    assert_response :success
  end

  test "should create classe_matiere" do
    assert_difference('ClasseMatiere.count') do
      post classe_matieres_url, params: { classe_matiere: { matiere_id: @classe_matiere.matiere_id, salle_de_class_id: @classe_matiere.salle_de_class_id } }
    end

    assert_redirected_to classe_matiere_url(ClasseMatiere.last)
  end

  test "should show classe_matiere" do
    get classe_matiere_url(@classe_matiere)
    assert_response :success
  end

  test "should get edit" do
    get edit_classe_matiere_url(@classe_matiere)
    assert_response :success
  end

  test "should update classe_matiere" do
    patch classe_matiere_url(@classe_matiere), params: { classe_matiere: { matiere_id: @classe_matiere.matiere_id, salle_de_class_id: @classe_matiere.salle_de_class_id } }
    assert_redirected_to classe_matiere_url(@classe_matiere)
  end

  test "should destroy classe_matiere" do
    assert_difference('ClasseMatiere.count', -1) do
      delete classe_matiere_url(@classe_matiere)
    end

    assert_redirected_to classe_matieres_url
  end
end
