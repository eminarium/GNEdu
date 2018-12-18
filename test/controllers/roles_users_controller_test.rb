require 'test_helper'

class RolesUsersControllerTest < ActionController::TestCase
  setup do
    @roles_user = roles_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:roles_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create roles_user" do
    assert_difference('RolesUser.count') do
      post :create, roles_user: { role_id: @roles_user.role_id, user_id: @roles_user.user_id }
    end

    assert_redirected_to roles_user_path(assigns(:roles_user))
  end

  test "should show roles_user" do
    get :show, id: @roles_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @roles_user
    assert_response :success
  end

  test "should update roles_user" do
    patch :update, id: @roles_user, roles_user: { role_id: @roles_user.role_id, user_id: @roles_user.user_id }
    assert_redirected_to roles_user_path(assigns(:roles_user))
  end

  test "should destroy roles_user" do
    assert_difference('RolesUser.count', -1) do
      delete :destroy, id: @roles_user
    end

    assert_redirected_to roles_users_path
  end
end
