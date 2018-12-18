require 'test_helper'

class ModObjectsControllerTest < ActionController::TestCase
  setup do
    @mod_object = mod_objects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mod_objects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mod_object" do
    assert_difference('ModObject.count') do
      post :create, mod_object: { description: @mod_object.description, modObjectName: @mod_object.modObjectName }
    end

    assert_redirected_to mod_object_path(assigns(:mod_object))
  end

  test "should show mod_object" do
    get :show, id: @mod_object
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mod_object
    assert_response :success
  end

  test "should update mod_object" do
    patch :update, id: @mod_object, mod_object: { description: @mod_object.description, modObjectName: @mod_object.modObjectName }
    assert_redirected_to mod_object_path(assigns(:mod_object))
  end

  test "should destroy mod_object" do
    assert_difference('ModObject.count', -1) do
      delete :destroy, id: @mod_object
    end

    assert_redirected_to mod_objects_path
  end
end
