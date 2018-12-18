json.array!(@states) do |state|
  json.extract! state, :id, :stateName, :notes
  json.url state_url(state, format: :json)
end
