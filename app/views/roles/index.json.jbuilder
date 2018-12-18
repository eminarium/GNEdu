json.array!(@roles) do |role|
  json.extract! role, :id, :roleName, :authorizable_type, :authorizable_id, :notes
  json.url role_url(role, format: :json)
end
