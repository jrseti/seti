require 'test_helper'

class ObservationRangesControllerTest < ActionController::TestCase
  setup do
    login_as_administrator
    @observation_range = observation_ranges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:observation_ranges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create observation_range" do
    assert_difference('ObservationRange.count') do
      post :create, :observation_range => @observation_range.attributes
    end

    assert_redirected_to observation_range_path(assigns(:observation_range))
  end

  test "should show observation_range" do
    get :show, :id => @observation_range.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @observation_range.to_param
    assert_response :success
  end

  test "should update observation_range" do
    put :update, :id => @observation_range.to_param, :observation_range => @observation_range.attributes
    assert_redirected_to observation_range_path(assigns(:observation_range))
  end

  test "should destroy observation_range" do
    assert_difference('ObservationRange.count', -1) do
      delete :destroy, :id => @observation_range.to_param
    end

    assert_redirected_to observation_ranges_path
  end
end
