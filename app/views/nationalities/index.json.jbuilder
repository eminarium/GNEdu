json.array!(@nationalities) do |nationality|
  json.extract! nationality, :id, :nationalityName, :notes
  json.url nationality_url(nationality, format: :json)
end
