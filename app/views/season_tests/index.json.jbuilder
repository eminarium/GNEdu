json.array!(@season_tests) do |season_test|
  json.extract! season_test, :id, :season_id, :seasonTestTitle, :seasonTestDate, :isFinal, :seasonTestNotes
  json.url season_test_url(season_test, format: :json)
end
