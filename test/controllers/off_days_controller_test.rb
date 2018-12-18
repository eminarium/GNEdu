require 'test_helper'

class OffDaysControllerTest < ActionController::TestCase
  setup do
    @off_day = off_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:off_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create off_day" do
    assert_difference('OffDay.count') do
      post :create, off_day: { is_annual: @off_day.is_annual, notes: @off_day.notes, off_day_date: @off_day.off_day_date, off_day_title: @off_day.off_day_title }
    end

    assert_redirected_to off_day_path(assigns(:off_day))
  end

  test "should show off_day" do
    get :show, id: @off_day
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @off_day
    assert_response :success
  end

  test "should update off_day" do
    patch :update, id: @off_day, off_day: { is_annual: @off_day.is_annual, notes: @off_day.notes, off_day_date: @off_day.off_day_date, off_day_title: @off_day.off_day_title }
    assert_redirected_to off_day_path(assigns(:off_day))
  end

  test "should destroy off_day" do
    assert_difference('OffDay.count', -1) do
      delete :destroy, id: @off_day
    end

    assert_redirected_to off_days_path
  end
end
