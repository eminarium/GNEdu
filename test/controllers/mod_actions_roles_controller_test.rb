require 'test_helper'

class ModActionsRolesControllerTest < ActionController::TestCase
  setup do
    @mod_actions_role = mod_actions_roles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mod_actions_roles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mod_actions_role" do
    assert_difference('ModActionsRole.count') do
      post :create, mod_actions_role: { allowAccess: @mod_actions_role.allowAccess, auditTrack: @mod_actions_role.auditTrack, modAction_id: @mod_actions_role.modAction_id, role_id: @mod_actions_role.role_id }
    end

    assert_redirected_to mod_actions_role_path(assigns(:mod_actions_role))
  end

  test "should show mod_actions_role" do
    get :show, id: @mod_actions_role
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mod_actions_role
    assert_response :success
  end

  test "should update mod_actions_role" do
    patch :update, id: @mod_actions_role, mod_actions_role: { allowAccess: @mod_actions_role.allowAccess, auditTrack: @mod_actions_role.auditTrack, modAction_id: @mod_actions_role.modAction_id, role_id: @mod_actions_role.role_id }
    assert_redirected_to mod_actions_role_path(assigns(:mod_actions_role))
  end

  test "should destroy mod_actions_role" do
    assert_difference('ModActionsRole.count', -1) do
      delete :destroy, id: @mod_actions_role
    end

    assert_redirected_to mod_actions_roles_path
  end
end
