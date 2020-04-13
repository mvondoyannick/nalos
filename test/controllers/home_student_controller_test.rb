require 'test_helper'

class HomeStudentControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get home_student_index_url
    assert_response :success
  end

end
