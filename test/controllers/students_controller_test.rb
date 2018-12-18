require 'test_helper'

class StudentsControllerTest < ActionController::TestCase
  setup do
    @student = students(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:students)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student" do
    assert_difference('Student.count') do
      post :create, student: { birthDate: @student.birthDate, fName: @student.fName, faFName: @student.faFName, faLName: @student.faLName, faMobilePhone: @student.faMobilePhone, faOccupation: @student.faOccupation, faOfficePhone: @student.faOfficePhone, faWorkPlace: @student.faWorkPlace, gender: @student.gender, higherSchoolGrade: @student.higherSchoolGrade, higherSchoolName: @student.higherSchoolName, isPupil: @student.isPupil, isStudent: @student.isStudent, isWorker: @student.isWorker, lName: @student.lName, maFName: @student.maFName, maLName: @student.maLName, maMobilePhone: @student.maMobilePhone, maOccupation: @student.maOccupation, maOfficePhone: @student.maOfficePhone, maWorkPlace: @student.maWorkPlace, mobilePhone: @student.mobilePhone, nationality_id: @student.nationality_id, notes: @student.notes, occupation: @student.occupation, officePhone: @student.officePhone, patronymic: @student.patronymic, schoolGrade: @student.schoolGrade, schoolName: @student.schoolName, schoolNo: @student.schoolNo, smsMobilePhone: @student.smsMobilePhone, workPlace: @student.workPlace }
    end

    assert_redirected_to student_path(assigns(:student))
  end

  test "should show student" do
    get :show, id: @student
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student
    assert_response :success
  end

  test "should update student" do
    patch :update, id: @student, student: { birthDate: @student.birthDate, fName: @student.fName, faFName: @student.faFName, faLName: @student.faLName, faMobilePhone: @student.faMobilePhone, faOccupation: @student.faOccupation, faOfficePhone: @student.faOfficePhone, faWorkPlace: @student.faWorkPlace, gender: @student.gender, higherSchoolGrade: @student.higherSchoolGrade, higherSchoolName: @student.higherSchoolName, isPupil: @student.isPupil, isStudent: @student.isStudent, isWorker: @student.isWorker, lName: @student.lName, maFName: @student.maFName, maLName: @student.maLName, maMobilePhone: @student.maMobilePhone, maOccupation: @student.maOccupation, maOfficePhone: @student.maOfficePhone, maWorkPlace: @student.maWorkPlace, mobilePhone: @student.mobilePhone, nationality_id: @student.nationality_id, notes: @student.notes, occupation: @student.occupation, officePhone: @student.officePhone, patronymic: @student.patronymic, schoolGrade: @student.schoolGrade, schoolName: @student.schoolName, schoolNo: @student.schoolNo, smsMobilePhone: @student.smsMobilePhone, workPlace: @student.workPlace }
    assert_redirected_to student_path(assigns(:student))
  end

  test "should destroy student" do
    assert_difference('Student.count', -1) do
      delete :destroy, id: @student
    end

    assert_redirected_to students_path
  end
end
