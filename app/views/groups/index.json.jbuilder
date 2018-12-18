json.array!(@groups) do |group|
  json.extract! group, :id, :subject_id, :season_id, :lessonTime_id, :teacher_id, :groupGender_id, :groupLanguage_id, :groupTitle, :isReserve, :groupLimit, :notes
  json.url group_url(group, format: :json)
end
