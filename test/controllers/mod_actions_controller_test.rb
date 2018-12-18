require 'test_helper'

class ModActionsControllerTest < ActionController::TestCase
  setup do
    @mod_action = mod_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mod_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mod_action" do
    assert_difference('ModAction.count') do
      post :create, mod_action: { auditTrack: @mod_action.auditTrack, description: @mod_action.description, modActionName: @mod_action.modActionName, modObject_id: @mod_action.modObject_id, role_id: @mod_action.role_id }
    end

    assert_redirected_to mod_action_path(assigns(:mod_action))
  end

  test "should show mod_action" do
    get :show, id: @mod_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mod_action
    assert_response :success
  end

  test "should update mod_action" do
    patch :update, id: @mod_action, mod_action: { auditTrack: @mod_action.auditTrack, description: @mod_action.description, modActionName: @mod_action.modActionName, modObject_id: @mod_action.modObject_id, role_id: @mod_action.role_id }
    assert_redirected_to mod_action_path(assigns(:mod_action))
  end

  test "should destroy mod_action" do
    assert_difference('ModAction.count', -1) do
      delete :destroy, id: @mod_action
    end

    assert_redirected_to mod_actions_path
  end
end
