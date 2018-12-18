json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :order_number, :notes
  json.url order_url(order, format: :json)
end
