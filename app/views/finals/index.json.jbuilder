json.array!(@finals) do |final|
  json.extract! final, :id, :contract_id, :finalPoints, :finalNotes
  json.url final_url(final, format: :json)
end
