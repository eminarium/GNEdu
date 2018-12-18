require 'test_helper'

class HighSchoolsControllerTest < ActionController::TestCase
  setup do
    @high_school = high_schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:high_schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create high_school" do
    assert_difference('HighSchool.count') do
      post :create, high_school: { highSchoolName: @high_school.highSchoolName, notes: @high_school.notes }
    end

    assert_redirected_to high_school_path(assigns(:high_school))
  end

  test "should show high_school" do
    get :show, id: @high_school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @high_school
    assert_response :success
  end

  test "should update high_school" do
    patch :update, id: @high_school, high_school: { highSchoolName: @high_school.highSchoolName, notes: @high_school.notes }
    assert_redirected_to high_school_path(assigns(:high_school))
  end

  test "should destroy high_school" do
    assert_difference('HighSchool.count', -1) do
      delete :destroy, id: @high_school
    end

    assert_redirected_to high_schools_path
  end
end
