require 'test_helper'

class SpecialGroupsControllerTest < ActionController::TestCase
  setup do
    @special_group = special_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:special_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special_group" do
    assert_difference('SpecialGroup.count') do
      post :create, special_group: { notes: @special_group.notes, season_id: @special_group.season_id, specialGroupTitle: @special_group.specialGroupTitle }
    end

    assert_redirected_to special_group_path(assigns(:special_group))
  end

  test "should show special_group" do
    get :show, id: @special_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special_group
    assert_response :success
  end

  test "should update special_group" do
    patch :update, id: @special_group, special_group: { notes: @special_group.notes, season_id: @special_group.season_id, specialGroupTitle: @special_group.specialGroupTitle }
    assert_redirected_to special_group_path(assigns(:special_group))
  end

  test "should destroy special_group" do
    assert_difference('SpecialGroup.count', -1) do
      delete :destroy, id: @special_group
    end

    assert_redirected_to special_groups_path
  end
end
