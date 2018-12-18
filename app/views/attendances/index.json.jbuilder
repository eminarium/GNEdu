json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :contract_id, :attendanceDate, :attendanceList, :attendanceNotes
  json.url attendance_url(attendance, format: :json)
end
