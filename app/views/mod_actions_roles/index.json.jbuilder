json.array!(@mod_actions_roles) do |mod_actions_role|
  json.extract! mod_actions_role, :id, :role_id, :modAction_id, :allowAccess, :auditTrack
  json.url mod_actions_role_url(mod_actions_role, format: :json)
end
