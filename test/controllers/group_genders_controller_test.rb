require 'test_helper'

class GroupGendersControllerTest < ActionController::TestCase
  setup do
    @group_gender = group_genders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_genders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_gender" do
    assert_difference('GroupGender.count') do
      post :create, group_gender: { groupGenderFullName: @group_gender.groupGenderFullName, groupGenderShortName: @group_gender.groupGenderShortName, notes: @group_gender.notes }
    end

    assert_redirected_to group_gender_path(assigns(:group_gender))
  end

  test "should show group_gender" do
    get :show, id: @group_gender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_gender
    assert_response :success
  end

  test "should update group_gender" do
    patch :update, id: @group_gender, group_gender: { groupGenderFullName: @group_gender.groupGenderFullName, groupGenderShortName: @group_gender.groupGenderShortName, notes: @group_gender.notes }
    assert_redirected_to group_gender_path(assigns(:group_gender))
  end

  test "should destroy group_gender" do
    assert_difference('GroupGender.count', -1) do
      delete :destroy, id: @group_gender
    end

    assert_redirected_to group_genders_path
  end
end
