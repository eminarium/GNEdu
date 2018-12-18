json.array!(@book_contests) do |book_contest|
  json.extract! book_contest, :id, :bookContestName, :season_id, :notes
  json.url book_contest_url(book_contest, format: :json)
end
