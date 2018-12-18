json.array!(@audits) do |audit|
  json.extract! audit, :id, :user_id, :modAction_id, :interactionDate
  json.url audit_url(audit, format: :json)
end
