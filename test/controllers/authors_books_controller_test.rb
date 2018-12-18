require 'test_helper'

class AuthorsBooksControllerTest < ActionController::TestCase
  setup do
    @authors_book = authors_books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authors_books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authors_book" do
    assert_difference('AuthorsBook.count') do
      post :create, authors_book: { author_id: @authors_book.author_id, book_id: @authors_book.book_id }
    end

    assert_redirected_to authors_book_path(assigns(:authors_book))
  end

  test "should show authors_book" do
    get :show, id: @authors_book
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authors_book
    assert_response :success
  end

  test "should update authors_book" do
    patch :update, id: @authors_book, authors_book: { author_id: @authors_book.author_id, book_id: @authors_book.book_id }
    assert_redirected_to authors_book_path(assigns(:authors_book))
  end

  test "should destroy authors_book" do
    assert_difference('AuthorsBook.count', -1) do
      delete :destroy, id: @authors_book
    end

    assert_redirected_to authors_books_path
  end
end
