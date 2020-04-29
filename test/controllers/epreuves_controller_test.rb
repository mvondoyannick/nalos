require 'test_helper'

class EpreuvesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @epreufe = epreuves(:one)
  end

  test "should get index" do
    get epreuves_url
    assert_response :success
  end

  test "should get new" do
    get new_epreufe_url
    assert_response :success
  end

  test "should create epreufe" do
    assert_difference('Epreuve.count') do
      post epreuves_url, params: { epreufe: { matiere_id: @epreufe.matiere_id, salle_de_class_id: @epreufe.salle_de_class_id, title: @epreufe.title, user_id: @epreufe.user_id } }
    end

    assert_redirected_to epreufe_url(Epreuve.last)
  end

  test "should show epreufe" do
    get epreufe_url(@epreufe)
    assert_response :success
  end

  test "should get edit" do
    get edit_epreufe_url(@epreufe)
    assert_response :success
  end

  test "should update epreufe" do
    patch epreufe_url(@epreufe), params: { epreufe: { matiere_id: @epreufe.matiere_id, salle_de_class_id: @epreufe.salle_de_class_id, title: @epreufe.title, user_id: @epreufe.user_id } }
    assert_redirected_to epreufe_url(@epreufe)
  end

  test "should destroy epreufe" do
    assert_difference('Epreuve.count', -1) do
      delete epreufe_url(@epreufe)
    end

    assert_redirected_to epreuves_url
  end
end
