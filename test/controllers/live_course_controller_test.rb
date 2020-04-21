require 'test_helper'

class LiveCourseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get live_course_index_url
    assert_response :success
  end

end
