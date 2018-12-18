json.array!(@subject_categories) do |subject_category|
  json.extract! subject_category, :id, :subjectCategoryFullName, :subjectCategoryShortName, :notes
  json.url subject_category_url(subject_category, format: :json)
end
