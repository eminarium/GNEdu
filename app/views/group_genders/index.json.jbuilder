json.array!(@group_genders) do |group_gender|
  json.extract! group_gender, :id, :groupGenderFullName, :groupGenderShortName, :notes
  json.url group_gender_url(group_gender, format: :json)
end
