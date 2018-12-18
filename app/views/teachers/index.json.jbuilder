json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :teacherFName, :teacherLName, :teacherPatronymic, :notes
  json.url teacher_url(teacher, format: :json)
end
