json.array!(@event_types) do |event_type|
  json.extract! event_type, :id, :event_type_title, :event_type_color_code, :notes
  json.url event_type_url(event_type, format: :json)
end
