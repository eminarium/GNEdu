json.array!(@events) do |event|
  json.extract! event, :id, :event_type_id, :event_title, :event_from_datetime, :event_to_datetime, :is_weekly, :notes
  json.url event_url(event, format: :json)
end
