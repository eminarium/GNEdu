json.array!(@rooms) do |room|
  json.extract! room, :id, :roomFullTitle, :roomShortTitle, :roomCapacity, :hasProjector, :hasEboard, :notes
  json.url room_url(room, format: :json)
end
