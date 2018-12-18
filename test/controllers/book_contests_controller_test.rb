require 'test_helper'

class BookContestsControllerTest < ActionController::TestCase
  setup do
    @book_contest = book_contests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_contests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_contest" do
    assert_difference('BookContest.count') do
      post :create, book_contest: { bookContestName: @book_contest.bookContestName, notes: @book_contest.notes, season_id: @book_contest.season_id }
    end

    assert_redirected_to book_contest_path(assigns(:book_contest))
  end

  test "should show book_contest" do
    get :show, id: @book_contest
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_contest
    assert_response :success
  end

  test "should update book_contest" do
    patch :update, id: @book_contest, book_contest: { bookContestName: @book_contest.bookContestName, notes: @book_contest.notes, season_id: @book_contest.season_id }
    assert_redirected_to book_contest_path(assigns(:book_contest))
  end

  test "should destroy book_contest" do
    assert_difference('BookContest.count', -1) do
      delete :destroy, id: @book_contest
    end

    assert_redirected_to book_contests_path
  end
end
