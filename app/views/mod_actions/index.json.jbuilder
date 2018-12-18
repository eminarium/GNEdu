json.array!(@mod_actions) do |mod_action|
  json.extract! mod_action, :id, :role_id, :ModObject_id, :modActionName, :auditTrack, :description
  json.url mod_action_url(mod_action, format: :json)
end
