require 'test_helper'

class NationalitiesControllerTest < ActionController::TestCase
  setup do
    @nationality = nationalities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nationalities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nationality" do
    assert_difference('Nationality.count') do
      post :create, nationality: { nationalityName: @nationality.nationalityName, notes: @nationality.notes }
    end

    assert_redirected_to nationality_path(assigns(:nationality))
  end

  test "should show nationality" do
    get :show, id: @nationality
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nationality
    assert_response :success
  end

  test "should update nationality" do
    patch :update, id: @nationality, nationality: { nationalityName: @nationality.nationalityName, notes: @nationality.notes }
    assert_redirected_to nationality_path(assigns(:nationality))
  end

  test "should destroy nationality" do
    assert_difference('Nationality.count', -1) do
      delete :destroy, id: @nationality
    end

    assert_redirected_to nationalities_path
  end
end
