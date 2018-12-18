require 'test_helper'

class ContestantBooksControllerTest < ActionController::TestCase
  setup do
    @contestant_book = contestant_books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contestant_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contestant_book" do
    assert_difference('ContestantBook.count') do
      post :create, contestant_book: { bookContest_id: @contestant_book.bookContest_id, book_id: @contestant_book.book_id, notes: @contestant_book.notes }
    end

    assert_redirected_to contestant_book_path(assigns(:contestant_book))
  end

  test "should show contestant_book" do
    get :show, id: @contestant_book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contestant_book
    assert_response :success
  end

  test "should update contestant_book" do
    patch :update, id: @contestant_book, contestant_book: { bookContest_id: @contestant_book.bookContest_id, book_id: @contestant_book.book_id, notes: @contestant_book.notes }
    assert_redirected_to contestant_book_path(assigns(:contestant_book))
  end

  test "should destroy contestant_book" do
    assert_difference('ContestantBook.count', -1) do
      delete :destroy, id: @contestant_book
    end

    assert_redirected_to contestant_books_path
  end
end
