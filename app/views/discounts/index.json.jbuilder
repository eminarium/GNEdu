json.array!(@discounts) do |discount|
  json.extract! discount, :id, :discountName, :discountPercent, :notes
  json.url discount_url(discount, format: :json)
end
