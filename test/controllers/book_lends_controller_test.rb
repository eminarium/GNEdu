require 'test_helper'

class BookLendsControllerTest < ActionController::TestCase
  setup do
    @book_lend = book_lends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_lends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_lend" do
    assert_difference('BookLend.count') do
      post :create, book_lend: { book_id: @book_lend.book_id, isDamaged: @book_lend.isDamaged, isReturned: @book_lend.isReturned, lendDateTime: @book_lend.lendDateTime, notes: @book_lend.notes, returnDateTime: @book_lend.returnDateTime, student_id: @book_lend.student_id }
    end

    assert_redirected_to book_lend_path(assigns(:book_lend))
  end

  test "should show book_lend" do
    get :show, id: @book_lend
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_lend
    assert_response :success
  end

  test "should update book_lend" do
    patch :update, id: @book_lend, book_lend: { book_id: @book_lend.book_id, isDamaged: @book_lend.isDamaged, isReturned: @book_lend.isReturned, lendDateTime: @book_lend.lendDateTime, notes: @book_lend.notes, returnDateTime: @book_lend.returnDateTime, student_id: @book_lend.student_id }
    assert_redirected_to book_lend_path(assigns(:book_lend))
  end

  test "should destroy book_lend" do
    assert_difference('BookLend.count', -1) do
      delete :destroy, id: @book_lend
    end

    assert_redirected_to book_lends_path
  end
end
