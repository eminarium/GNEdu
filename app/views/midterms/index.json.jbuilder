json.array!(@midterms) do |midterm|
  json.extract! midterm, :id, :contract_id, :midtermOrderNo, :midtermPoints, :isReleasedFrom, :midtermNotes
  json.url midterm_url(midterm, format: :json)
end
