require 'test_helper'

class BookContestParticipantsControllerTest < ActionController::TestCase
  setup do
    @book_contest_participant = book_contest_participants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:book_contest_participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book_contest_participant" do
    assert_difference('BookContestParticipant.count') do
      post :create, book_contest_participant: { bookContest_id: @book_contest_participant.bookContest_id, book_id: @book_contest_participant.book_id, notes: @book_contest_participant.notes, student_id: @book_contest_participant.student_id }
    end

    assert_redirected_to book_contest_participant_path(assigns(:book_contest_participant))
  end

  test "should show book_contest_participant" do
    get :show, id: @book_contest_participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @book_contest_participant
    assert_response :success
  end

  test "should update book_contest_participant" do
    patch :update, id: @book_contest_participant, book_contest_participant: { bookContest_id: @book_contest_participant.bookContest_id, book_id: @book_contest_participant.book_id, notes: @book_contest_participant.notes, student_id: @book_contest_participant.student_id }
    assert_redirected_to book_contest_participant_path(assigns(:book_contest_participant))
  end

  test "should destroy book_contest_participant" do
    assert_difference('BookContestParticipant.count', -1) do
      delete :destroy, id: @book_contest_participant
    end

    assert_redirected_to book_contest_participants_path
  end
end
