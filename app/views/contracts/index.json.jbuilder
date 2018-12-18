json.array!(@contracts) do |contract|
  json.extract! contract, :id, :seasonContractNo, :season_id, :group_id, :student_id, :discount_id, :registrationDate, :isBookGiven, :amountPaid, :isMoneyReturned, :notes
  json.url contract_url(contract, format: :json)
end
