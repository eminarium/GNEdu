json.array!(@notes_users) do |notes_user|
  json.extract! notes_user, :id, :note_id, :user_id
  json.url notes_user_url(notes_user, format: :json)
end
