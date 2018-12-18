json.array!(@seasons) do |season|
  json.extract! season, :id, :seasonTitle, :seasonFromDate, :seasonToDate, :notes
  json.url season_url(season, format: :json)
end
