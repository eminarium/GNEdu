json.array!(@timetables) do |timetable|
  json.extract! timetable, :id, :group_id, :room_id, :weekday, :notes
  json.url timetable_url(timetable, format: :json)
end
