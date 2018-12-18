json.array!(@high_schools) do |high_school|
  json.extract! high_school, :id, :highSchoolName, :notes
  json.url high_school_url(high_school, format: :json)
end
