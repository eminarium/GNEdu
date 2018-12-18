json.array!(@group_languages) do |group_language|
  json.extract! group_language, :id, :groupLanguageFullName, :groupLanguageShortName, :notes
  json.url group_language_url(group_language, format: :json)
end
