json.array!(@special_schools) do |special_school|
  json.extract! special_school, :id, :specialSchoolName, :notes
  json.url special_school_url(special_school, format: :json)
end
