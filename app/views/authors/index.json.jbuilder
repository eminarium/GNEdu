json.array!(@authors) do |author|
  json.extract! author, :id, :authorFName, :authorLName, :notes
  json.url author_url(author, format: :json)
end
