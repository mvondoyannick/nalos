require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get people_search_url
    assert_response :success
  end

end
