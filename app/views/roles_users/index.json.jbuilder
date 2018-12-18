json.array!(@roles_users) do |roles_user|
  json.extract! roles_user, :id, :role_id, :user_id
  json.url roles_user_url(roles_user, format: :json)
end
