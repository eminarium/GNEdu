require 'test_helper'

class FinalsControllerTest < ActionController::TestCase
  setup do
    @final = finals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:finals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create final" do
    assert_difference('Final.count') do
      post :create, final: { contract_id: @final.contract_id, finalNotes: @final.finalNotes, finalPoints: @final.finalPoints }
    end

    assert_redirected_to final_path(assigns(:final))
  end

  test "should show final" do
    get :show, id: @final
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @final
    assert_response :success
  end

  test "should update final" do
    patch :update, id: @final, final: { contract_id: @final.contract_id, finalNotes: @final.finalNotes, finalPoints: @final.finalPoints }
    assert_redirected_to final_path(assigns(:final))
  end

  test "should destroy final" do
    assert_difference('Final.count', -1) do
      delete :destroy, id: @final
    end

    assert_redirected_to finals_path
  end
end
