require 'test_helper'

class LessonTimesControllerTest < ActionController::TestCase
  setup do
    @lesson_time = lesson_times(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lesson_times)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lesson_time" do
    assert_difference('LessonTime.count') do
      post :create, lesson_time: { lessonTimeFrom: @lesson_time.lessonTimeFrom, lessonTimeTitle: @lesson_time.lessonTimeTitle, lessonTimeTo: @lesson_time.lessonTimeTo, notes: @lesson_time.notes }
    end

    assert_redirected_to lesson_time_path(assigns(:lesson_time))
  end

  test "should show lesson_time" do
    get :show, id: @lesson_time
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lesson_time
    assert_response :success
  end

  test "should update lesson_time" do
    patch :update, id: @lesson_time, lesson_time: { lessonTimeFrom: @lesson_time.lessonTimeFrom, lessonTimeTitle: @lesson_time.lessonTimeTitle, lessonTimeTo: @lesson_time.lessonTimeTo, notes: @lesson_time.notes }
    assert_redirected_to lesson_time_path(assigns(:lesson_time))
  end

  test "should destroy lesson_time" do
    assert_difference('LessonTime.count', -1) do
      delete :destroy, id: @lesson_time
    end

    assert_redirected_to lesson_times_path
  end
end
