require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  test "should get preferences" do
    get :preferences
    assert_response :success
  end

end
