class Order < ActiveRecord::Base
  self.primary_keys = :user_id, :order_number
  belongs_to :user
end
