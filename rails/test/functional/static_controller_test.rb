require 'test_helper'

class StaticControllerTest < ActionController::TestCase
  test "should get setiquest_explorer" do
    get :setiquest_explorer
    assert_response :success
  end

end
