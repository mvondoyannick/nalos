require 'test_helper'

class SetupControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get setup_index_url
    assert_response :success
  end

  test "should get enseignant_index" do
    get setup_enseignant_index_url
    assert_response :success
  end

  test "should get student_index" do
    get setup_student_index_url
    assert_response :success
  end

  test "should get notification_index" do
    get setup_notification_index_url
    assert_response :success
  end

  test "should get course_index" do
    get setup_course_index_url
    assert_response :success
  end

end
