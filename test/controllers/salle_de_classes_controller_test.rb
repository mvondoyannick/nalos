require 'test_helper'

class SalleDeClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @salle_de_class = salle_de_classes(:one)
  end

  test "should get index" do
    get salle_de_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_salle_de_class_url
    assert_response :success
  end

  test "should create salle_de_class" do
    assert_difference('SalleDeClass.count') do
      post salle_de_classes_url, params: { salle_de_class: { cycle_id: @salle_de_class.cycle_id, effectif: @salle_de_class.effectif, name: @salle_de_class.name } }
    end

    assert_redirected_to salle_de_class_url(SalleDeClass.last)
  end

  test "should show salle_de_class" do
    get salle_de_class_url(@salle_de_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_salle_de_class_url(@salle_de_class)
    assert_response :success
  end

  test "should update salle_de_class" do
    patch salle_de_class_url(@salle_de_class), params: { salle_de_class: { cycle_id: @salle_de_class.cycle_id, effectif: @salle_de_class.effectif, name: @salle_de_class.name } }
    assert_redirected_to salle_de_class_url(@salle_de_class)
  end

  test "should destroy salle_de_class" do
    assert_difference('SalleDeClass.count', -1) do
      delete salle_de_class_url(@salle_de_class)
    end

    assert_redirected_to salle_de_classes_url
  end
end
