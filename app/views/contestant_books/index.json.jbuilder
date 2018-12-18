json.array!(@contestant_books) do |contestant_book|
  json.extract! contestant_book, :id, :book_id, :bookContest_id, :notes
  json.url contestant_book_url(contestant_book, format: :json)
end
