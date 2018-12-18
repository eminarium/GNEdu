json.array!(@subjects) do |subject|
  json.extract! subject, :id, :subjectBaseName, :subjectFullName, :subjectShortName, :subjectLevel, :subjectPrice, :minPassingPoints, :notes
  json.url subject_url(subject, format: :json)
end
