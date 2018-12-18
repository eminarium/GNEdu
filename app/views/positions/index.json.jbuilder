json.array!(@positions) do |position|
  json.extract! position, :id, :user_id, :position_number, :notes
  json.url position_url(position, format: :json)
end
