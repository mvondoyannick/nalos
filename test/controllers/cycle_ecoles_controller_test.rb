require 'test_helper'

class CycleEcolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cycle_ecole = cycle_ecoles(:one)
  end

  test "should get index" do
    get cycle_ecoles_url
    assert_response :success
  end

  test "should get new" do
    get new_cycle_ecole_url
    assert_response :success
  end

  test "should create cycle_ecole" do
    assert_difference('CycleEcole.count') do
      post cycle_ecoles_url, params: { cycle_ecole: { code: @cycle_ecole.code, detail: @cycle_ecole.detail, name: @cycle_ecole.name, structure_id: @cycle_ecole.structure_id } }
    end

    assert_redirected_to cycle_ecole_url(CycleEcole.last)
  end

  test "should show cycle_ecole" do
    get cycle_ecole_url(@cycle_ecole)
    assert_response :success
  end

  test "should get edit" do
    get edit_cycle_ecole_url(@cycle_ecole)
    assert_response :success
  end

  test "should update cycle_ecole" do
    patch cycle_ecole_url(@cycle_ecole), params: { cycle_ecole: { code: @cycle_ecole.code, detail: @cycle_ecole.detail, name: @cycle_ecole.name, structure_id: @cycle_ecole.structure_id } }
    assert_redirected_to cycle_ecole_url(@cycle_ecole)
  end

  test "should destroy cycle_ecole" do
    assert_difference('CycleEcole.count', -1) do
      delete cycle_ecole_url(@cycle_ecole)
    end

    assert_redirected_to cycle_ecoles_url
  end
end
