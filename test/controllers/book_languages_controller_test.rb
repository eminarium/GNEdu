require 'test_helper'

class BookLanguagesControllerTest < ActionController::TestCase
  setup do
    @book_language = book_languages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_language" do
    assert_difference('BookLanguage.count') do
      post :create, book_language: { bookLanguageFullName: @book_language.bookLanguageFullName, bookLanguageShortName: @book_language.bookLanguageShortName, notes: @book_language.notes }
    end

    assert_redirected_to book_language_path(assigns(:book_language))
  end

  test "should show book_language" do
    get :show, id: @book_language
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_language
    assert_response :success
  end

  test "should update book_language" do
    patch :update, id: @book_language, book_language: { bookLanguageFullName: @book_language.bookLanguageFullName, bookLanguageShortName: @book_language.bookLanguageShortName, notes: @book_language.notes }
    assert_redirected_to book_language_path(assigns(:book_language))
  end

  test "should destroy book_language" do
    assert_difference('BookLanguage.count', -1) do
      delete :destroy, id: @book_language
    end

    assert_redirected_to book_languages_path
  end
end
