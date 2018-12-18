json.array!(@authors_books) do |authors_book|
  json.extract! authors_book, :id, :book_id, :author_id
  json.url authors_book_url(authors_book, format: :json)
end
