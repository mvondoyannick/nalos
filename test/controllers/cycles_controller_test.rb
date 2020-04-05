require 'test_helper'

class CyclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cycle = cycles(:one)
  end

  test "should get index" do
    get cycles_url
    assert_response :success
  end

  test "should get new" do
    get new_cycle_url
    assert_response :success
  end

  test "should create cycle" do
    assert_difference('Cycle.count') do
      post cycles_url, params: { cycle: { name: @cycle.name, structure_id: @cycle.structure_id } }
    end

    assert_redirected_to cycle_url(Cycle.last)
  end

  test "should show cycle" do
    get cycle_url(@cycle)
    assert_response :success
  end

  test "should get edit" do
    get edit_cycle_url(@cycle)
    assert_response :success
  end

  test "should update cycle" do
    patch cycle_url(@cycle), params: { cycle: { name: @cycle.name, structure_id: @cycle.structure_id } }
    assert_redirected_to cycle_url(@cycle)
  end

  test "should destroy cycle" do
    assert_difference('Cycle.count', -1) do
      delete cycle_url(@cycle)
    end

    assert_redirected_to cycles_url
  end
end
