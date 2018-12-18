require 'test_helper'

class AttendanceSheetsControllerTest < ActionController::TestCase
  setup do
    @attendance_sheet = attendance_sheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendance_sheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendance_sheet" do
    assert_difference('AttendanceSheet.count') do
      post :create, attendance_sheet: { attendanceSheetDate: @attendance_sheet.attendanceSheetDate, attendanceSheetNotes: @attendance_sheet.attendanceSheetNotes, group_id: @attendance_sheet.group_id }
    end

    assert_redirected_to attendance_sheet_path(assigns(:attendance_sheet))
  end

  test "should show attendance_sheet" do
    get :show, id: @attendance_sheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendance_sheet
    assert_response :success
  end

  test "should update attendance_sheet" do
    patch :update, id: @attendance_sheet, attendance_sheet: { attendanceSheetDate: @attendance_sheet.attendanceSheetDate, attendanceSheetNotes: @attendance_sheet.attendanceSheetNotes, group_id: @attendance_sheet.group_id }
    assert_redirected_to attendance_sheet_path(assigns(:attendance_sheet))
  end

  test "should destroy attendance_sheet" do
    assert_difference('AttendanceSheet.count', -1) do
      delete :destroy, id: @attendance_sheet
    end

    assert_redirected_to attendance_sheets_path
  end
end
