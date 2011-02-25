require 'test_helper'

class PatternMarksControllerTest < ActionController::TestCase
  setup do
    @pattern_mark = pattern_marks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pattern_marks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pattern_mark" do
    assert_difference('PatternMark.count') do
      post :create, :pattern_mark => @pattern_mark.attributes
    end

    assert_redirected_to pattern_mark_path(assigns(:pattern_mark))
  end

  test "should show pattern_mark" do
    get :show, :id => @pattern_mark.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @pattern_mark.to_param
    assert_response :success
  end

  test "should update pattern_mark" do
    put :update, :id => @pattern_mark.to_param, :pattern_mark => @pattern_mark.attributes
    assert_redirected_to pattern_mark_path(assigns(:pattern_mark))
  end

  test "should destroy pattern_mark" do
    assert_difference('PatternMark.count', -1) do
      delete :destroy, :id => @pattern_mark.to_param
    end

    assert_redirected_to pattern_marks_path
  end
end
