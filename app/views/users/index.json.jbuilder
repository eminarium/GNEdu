json.array!(@users) do |user|
  json.extract! user, :id, :userLogin, :userFName, :userLName, :crypted_password, :password_salt, :persistence_token, :notes
  json.url user_url(user, format: :json)
end
