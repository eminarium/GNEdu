json.array!(@cities) do |city|
  json.extract! city, :id, :cityName, :state_id, :notes
  json.url city_url(city, format: :json)
end
