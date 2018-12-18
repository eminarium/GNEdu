require 'test_helper'

class GroupLanguagesControllerTest < ActionController::TestCase
  setup do
    @group_language = group_languages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_language" do
    assert_difference('GroupLanguage.count') do
      post :create, group_language: { groupLanguageFullName: @group_language.groupLanguageFullName, groupLanguageShortName: @group_language.groupLanguageShortName, notes: @group_language.notes }
    end

    assert_redirected_to group_language_path(assigns(:group_language))
  end

  test "should show group_language" do
    get :show, id: @group_language
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_language
    assert_response :success
  end

  test "should update group_language" do
    patch :update, id: @group_language, group_language: { groupLanguageFullName: @group_language.groupLanguageFullName, groupLanguageShortName: @group_language.groupLanguageShortName, notes: @group_language.notes }
    assert_redirected_to group_language_path(assigns(:group_language))
  end

  test "should destroy group_language" do
    assert_difference('GroupLanguage.count', -1) do
      delete :destroy, id: @group_language
    end

    assert_redirected_to group_languages_path
  end
end
