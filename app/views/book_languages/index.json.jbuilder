json.array!(@book_languages) do |book_language|
  json.extract! book_language, :id, :bookLanguageFullName, :bookLanguageShortName, :notes
  json.url book_language_url(book_language, format: :json)
end
