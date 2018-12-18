json.array!(@lesson_times) do |lesson_time|
  json.extract! lesson_time, :id, :lessonTimeTitle, :lessonTimeFrom, :lessonTimeTo, :notes
  json.url lesson_time_url(lesson_time, format: :json)
end
