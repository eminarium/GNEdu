json.array!(@book_contest_participants) do |book_contest_participant|
  json.extract! book_contest_participant, :id, :student_id, :bookContest_id, :book_id, :notes
  json.url book_contest_participant_url(book_contest_participant, format: :json)
end
