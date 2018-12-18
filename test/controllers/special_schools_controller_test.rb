require 'test_helper'

class SpecialSchoolsControllerTest < ActionController::TestCase
  setup do
    @special_school = special_schools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:special_schools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special_school" do
    assert_difference('SpecialSchool.count') do
      post :create, special_school: { notes: @special_school.notes, specialSchoolName: @special_school.specialSchoolName }
    end

    assert_redirected_to special_school_path(assigns(:special_school))
  end

  test "should show special_school" do
    get :show, id: @special_school
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special_school
    assert_response :success
  end

  test "should update special_school" do
    patch :update, id: @special_school, special_school: { notes: @special_school.notes, specialSchoolName: @special_school.specialSchoolName }
    assert_redirected_to special_school_path(assigns(:special_school))
  end

  test "should destroy special_school" do
    assert_difference('SpecialSchool.count', -1) do
      delete :destroy, id: @special_school
    end

    assert_redirected_to special_schools_path
  end
end
