json.array!(@special_groups) do |special_group|
  json.extract! special_group, :id, :season_id, :specialGroupTitle, :notes
  json.url special_group_url(special_group, format: :json)
end
