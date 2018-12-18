require 'test_helper'

class SeasonTestsControllerTest < ActionController::TestCase
  setup do
    @season_test = season_tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:season_tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create season_test" do
    assert_difference('SeasonTest.count') do
      post :create, season_test: { isFinal: @season_test.isFinal, seasonTestDate: @season_test.seasonTestDate, seasonTestNotes: @season_test.seasonTestNotes, seasonTestTitle: @season_test.seasonTestTitle, season_id: @season_test.season_id }
    end

    assert_redirected_to season_test_path(assigns(:season_test))
  end

  test "should show season_test" do
    get :show, id: @season_test
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @season_test
    assert_response :success
  end

  test "should update season_test" do
    patch :update, id: @season_test, season_test: { isFinal: @season_test.isFinal, seasonTestDate: @season_test.seasonTestDate, seasonTestNotes: @season_test.seasonTestNotes, seasonTestTitle: @season_test.seasonTestTitle, season_id: @season_test.season_id }
    assert_redirected_to season_test_path(assigns(:season_test))
  end

  test "should destroy season_test" do
    assert_difference('SeasonTest.count', -1) do
      delete :destroy, id: @season_test
    end

    assert_redirected_to season_tests_path
  end
end
