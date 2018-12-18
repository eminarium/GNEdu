json.array!(@books) do |book|
  json.extract! book, :id, :bookLanguage_id, :bookName, :imageUrl, :totalQuantity, :notes
  json.url book_url(book, format: :json)
end
