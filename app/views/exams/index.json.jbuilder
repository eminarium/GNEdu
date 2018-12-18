json.array!(@exams) do |exam|
  json.extract! exam, :id, :examinee_id, :subject_id, :examDate, :examResult, :notes
  json.url exam_url(exam, format: :json)
end
