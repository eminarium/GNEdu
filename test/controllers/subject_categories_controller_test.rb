require 'test_helper'

class SubjectCategoriesControllerTest < ActionController::TestCase
  setup do
    @subject_category = subject_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subject_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subject_category" do
    assert_difference('SubjectCategory.count') do
      post :create, subject_category: { notes: @subject_category.notes, subjectCategoryFullName: @subject_category.subjectCategoryFullName, subjectCategoryShortName: @subject_category.subjectCategoryShortName }
    end

    assert_redirected_to subject_category_path(assigns(:subject_category))
  end

  test "should show subject_category" do
    get :show, id: @subject_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @subject_category
    assert_response :success
  end

  test "should update subject_category" do
    patch :update, id: @subject_category, subject_category: { notes: @subject_category.notes, subjectCategoryFullName: @subject_category.subjectCategoryFullName, subjectCategoryShortName: @subject_category.subjectCategoryShortName }
    assert_redirected_to subject_category_path(assigns(:subject_category))
  end

  test "should destroy subject_category" do
    assert_difference('SubjectCategory.count', -1) do
      delete :destroy, id: @subject_category
    end

    assert_redirected_to subject_categories_path
  end
end
